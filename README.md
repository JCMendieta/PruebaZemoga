# PruebaZemoga

<img src="https://github.com/JCMendieta/PruebaZemoga/blob/main/Images/PostScreenDeletedData.png" width="20%"></img>
<img src="https://github.com/JCMendieta/PruebaZemoga/blob/main/Images/PostDetailsScreen.png" width="20%"></img>
<img src="https://github.com/JCMendieta/PruebaZemoga/blob/main/Images/demo.gif" width="22%"></img>


## The app was divided in 5 folders: Views, Models, View models, Project files and Utils.
- The Views folder contains the files used to create the visual components in the screens of posts and post details.
- The Models folder contains the basic structures to represent the data requested from the JSON, it also has the fetch service and the coordinator that manages what view needs to be shown in the app.
- The View model folder constains the structure needed to represent the data that is going to be shown in the screen, it has some methods to update his data.
- Project files contains the configuration files of the project and resources such as images and icons.
- Utils contains useful data and methods that could be needed in different parts of the application Utils provide an easy way to access these.

## Models

### Posts

```swift
struct Posts: Codable {
    var result: [Post]
}
```

```swift
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
```

### Comment
```swift
struct Comment: Codable {
    let postId, id: Int
    let name, email, body: String
}
```

### User
```swift
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}
```

## ViewModels

### PostScreenViewModel
```swift
struct PostsScreenViewModel {
    var posts: [PostViewModel]
    var favoritePosts: [FavoritePostViewModel]
    
    mutating func addToFavorite(post: PostViewModel, indexRow: Int) {
        if post.isFavorite == false {
            posts[indexRow].isFavorite = true
            let favoritePost = FavoritePostViewModel(post: post, id: indexRow)
            favoritePosts.append(favoritePost)
        }
    }
    
    mutating func removeFromFavorite(at index: Int) {
        let idOriginalPost = favoritePosts[index].id
        favoritePosts.remove(at: index)
        posts[idOriginalPost].isFavorite = false
    }
    
    mutating func removeNotFavoritePosts() {
        let onlyFavoritePosts = posts.filter { post in
            post.isFavorite
        }
        posts = onlyFavoritePosts
    }
    
    mutating func removePostWith(index: Int){
        let indexOfFavoritePost = favoritePosts.firstIndex { favoritePost in
            favoritePost.id == index
        }
        if let index = indexOfFavoritePost {
            favoritePosts.remove(at: index)
        }
        posts.remove(at: index)
    }
    
    mutating func removePostFromfavoriteWith(index: Int){
        let originalIndex = favoritePosts[index].id
        posts[originalIndex].isFavorite = false
        favoritePosts.remove(at: index)
    }
}
```
## Fetch

### FetchPostsManager - Used to fetch users or post data.
```swift
struct FetchPostsManager {
    let postsStringURL = URLs.posts
    let usersStringURL = URLs.users
    var delegate: FetchPostsManagerDelegate?
    
    func fetchPosts(){
        if let url = URL(string: postsStringURL) {
            performRequest(url: url, for: .posts)
        }
    }
    
    func fetchUsers(){
        if let url = URL(string: usersStringURL) {
            performRequest(url: url, for: .users)
        }
    }
    
    func performRequest(url: URL, for fetchType: FetchType){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                switch fetchType {
                case .posts:
                    parsePostsJSON(json: safeData)
                case .users:
                    parseUsersJSON(json: safeData)
                }
                
            }
        }
        task.resume()
    }
    
    func parsePostsJSON(json: Data) {
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Post].self, from: json){
            let postsScreenViewModel = Utils.getPostsViewModel(posts: decodedData)
            let viewModel = PostsScreenViewModel(posts: postsScreenViewModel, favoritePosts: [])
            delegate?.didUpdatePosts(with: viewModel)
        }
    }
    
    func parseUsersJSON(json: Data) {
        let decoder = JSONDecoder()
        if let users = try? decoder.decode([User].self, from: json){
            delegate?.didUpdateUsers(with: users)
        }
    }
}
```

### FetchPostsDetailsManager
```swift
struct FetchPostsDetailsManager {
    let commentsStringURL = URLs.commets
    var delegate: FetchPostDetailsManagerDelegate?
    
    func getCommentsForPostWith(id: Int){
        if let url = URL(string: "\(commentsStringURL)\(id)/comments") {
            performRequest(url: url)
        }
    }
    
    func performRequest(url: URL){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){ (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                parseCommentsJSON(json: safeData)
            }
        }
        task.resume()
    }
    
    func parseCommentsJSON(json: Data) {
        let decoder = JSONDecoder()
        if let comments = try? decoder.decode([Comment].self, from: json){
            delegate?.didUpdateComments(with: comments)
        }
    }
}
```

### FetchType - Used to recognize which function will be called inside FetchPostManager
```swift
enum FetchType {
    case posts, users
}
```
## Utils


### Utils - Contains a method to return an array of PostViewModel with the favorite attribute from an array of Post
```swift
struct Utils {
    static func getPostsViewModel(posts: [Post]) -> [PostViewModel] {
        posts.map { post in
            return PostViewModel(
                userId: post.userId,
                postId: post.id,
                title: post.title,
                body: post.body,
                isFavorite: false
            )
        }
    }
}
```

## FetchType - It is used to specify the type of data that is going to be fetched in FetchPostManager
```swift
enum FetchType {
    case posts, users
}
```

## URLs - The URLs used in FetchPostsManager and FetchPostDetailManager
```swift
struct URLs {
    static let posts = "https://jsonplaceholder.typicode.com/posts"
    static let users = "https://jsonplaceholder.typicode.com/users"
    static let commets = "https://jsonplaceholder.typicode.com/posts/"
}
```
