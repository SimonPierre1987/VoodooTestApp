# Voodoo iOS Founding Engineer Test


## Explanation of my technical work:

## - Infinite scroll:
I hope this feature will demonstrate my understanding of actor and actor reentrancy. As my understing of the lazyStack and the lazyStack content life cycle. 
The PhotosDownloader enables to cache downloaded pages and is optimized for such a feature.
Of course the cache should be cleared when the user scrolls too much. I had no time to implement the clearing management. But I wanted to point at that I am aware of such a requirement. I prefered, in the little among of time I had, to focus on others features and demonstrate other abilities. 
Be aware that if you scroll too much you will surely receive a 403 error or a too many request error on the Unsplash API.

## - Network
I set up a minimal Network architecture with genericity and async/await that enabled me to build all services associated with the unsplash API. 
I was very limited by the fact that I couldn't get a user via the /me endoint for the current client_id. 
This had a lot of consequences and limitations as I couldn't set the scope to write likes and followers and get the required authorisation for POST/DELETE services. 
It took me a lot of time to understand where to go from here.
Hopefully I will have demonstrate my basic understanding of:
- async/await
- genericity
- the separation between the DTO and other layers data.
- How to build services and endpoint.

## - Like feature:
Thought I had no access token and no ability to really update the backend database via the like/dislike endpoint, I decided to implemented the feature.
I built the endpoints (POST/DELETE) with the correct generic types and Ì am sure the services would be effective "as it" with the required permissions.
I mocked the like/dislike answers as "always successful" in order to fake a positive reaction from the backend.

The UI implementation of the like/dislike on the FeedPage was tricky. I will explain here the glitch and how I solved the glitch in my limited time.
First I have to say that the LazyVStack on the FeedView is compulsory to enable infinite scroll with a good memory usage.
The naive approach to only modified the « isLikedByUser » property of the PhotoEntity when a user likes/dislikes a photo was creating a glitch on the lazyVStack:
- the async image of the FeedItemView was refetched because the photo state of the FeedItemView has changed.

To have a great responsive UI I had to create a "SinglePhotoDownloader" that would save the image downloaded at a specific url for a photo. This way I don’t have to use the AsyncImage and the glitch vanishes.
It took me some times to implement this solution but it is working as I want.

I hope this feature will demonstrate my abilities to implement a feature correctly and have quick ideas to solve unexpected issues:
- /me give me no access_token and I can't use the like/dislike endpoints 
- the glitch

## User Profile
I implemented a minimal user profile view to show my ability to create SwiftUI view, organize the SwiftUI View hiearchies and how to share states between views with methodology.
Thanks to the SinglePhotoDownloader images that were downloaded in the past are not refetched.
The current user can like/dislike photo directly from this page and can also see the picture in full screen.

## Navigation to user profile
From a user profile picture displayed on a photo, the current user can navigate to the user profile.
From the current user profile picture displayed in the setting the current user can navigate to its profile.

## Clean code
I tried to write readable code. I hope my code will demonstrate my care and great effort for having a code with:
- good naming
- the refactoring of dubious code, the implementation of new feature without breaking the existing features.
- the clarity and organisation of the code of each View I created.
- The use of @Observable.
- The organisation of files, the usagae of // MARK, the usage of private extension to achieve a clear code.
- The organisation of folders.
- the optimisation of fetches and network usage.

# Missing features 
Some features of my Product vision are missing. I had no time to implement them.
About the following/unfollowing feature we can say that it is exactly the same methodology as the like/dislike feature.
I didn't have time to implement the business account creation.

## Disclaimer
I didn't find in the documentation the precise description of an answer of a specific endpoint.
Decoding the API answers was difficult as I didn't know that some properties of the answers were optional. 
I try to limit the number of optional in my DTO.
If the infinit scroll does not work (it is not the case for me) it is because I am missing an optional. So far the infinite scroll relies on a "not failing" API or decoding. It could be otherwise with a refactoring.

## Conclusion
I would be pleased to discuss the details of my product vision and my code with your team.
