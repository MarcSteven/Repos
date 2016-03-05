import Foundation

class RepositoriesViewModel {
    var repos = [Repository]()
    
    let client = SearchRepositoriesClient()
    let parser = RepositoriesParser()
    
    func refresh(completion: () -> Void) {
        client.fetchRepositories { [unowned self] data in
            if let repositories = self.parser.repositoriesFromSearchResponse(data) {
                self.repos = repositories
            }
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return repos.count
    }
    
    func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < repos.count else {
            return ""
        }
        
        return repos[indexPath.row].name
    }
    
    func detailViewModelForRowAtIndexPath(indexPath: NSIndexPath) -> RepositoryDetailViewModel {
        let repo = repos[indexPath.row]
        return RepositoryDetailViewModel(repository: repo)
    }
}