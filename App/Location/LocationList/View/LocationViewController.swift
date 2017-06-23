import UIKit
import ASToast

class LocationViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LocationPresenter?
    var viewModel: SelectableLocationListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        
        self.searchBar.delegate = self
        self.spinner.hidesWhenStopped = true
        
        self.presenter?.loadContent()
    }
    
    // MARK: Actions
    
    func cancelAction() {
        self.searchBar.resignFirstResponder()
        self.presenter?.cancelSearchForLocation()
    }
    
    // MARK: Helpers
    
    fileprivate func showToastWithText(_ text: String) {
        
        view.makeToast(message: text, duration: TimeInterval(3.0), position: .center, backgroundColor: nil, messageColor: nil, font: nil)
    }
    
}

// MARK: - <LocationView>
extension LocationViewController: LocationView {
    
    func displayLoading() {
        self.searchBar.isHidden = false
        self.tableView.isHidden = true
        self.spinner.startAnimating()
    }

    func displaySearch() {
        self.searchBar.isHidden = false
        self.tableView.isHidden = false
        self.spinner.stopAnimating()
        
        self.searchBar.becomeFirstResponder()
    }

    func displayNoResults() {
        self.searchBar.isHidden = false
        self.tableView.isHidden = false
        self.spinner.stopAnimating()
        
        self.viewModel = nil
        self.tableView.reloadData()
        
        self.showToastWithText("No Results")
    }

    func displayErrorMessage(_ errorMessage: String) {
        self.searchBar.isHidden = false
        self.tableView.isHidden = false
        self.spinner.stopAnimating()
        
        self.showToastWithText(errorMessage)
    }

    func displayLocations(_ viewModel: SelectableLocationListViewModel) {
        self.searchBar.isHidden = false
        self.tableView.isHidden = false
        self.spinner.stopAnimating()
        
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
    
}

// MARK: - <UISearchBarDelegate>
extension LocationViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.presenter?.searchLocation(text)
        }
    }
    
}

// MARK: - <UITableViewDelegate>
extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = self.viewModel?.locations[indexPath.row] {
            self.presenter?.selectLocation(location.locationId)
        }
    }
    
}

// MARK: - <UITableViewDataSource>
extension LocationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.locations.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "LocationCell")
        }
        
        if let location = self.viewModel?.locations[indexPath.row] {
            cell?.textLabel?.text = location.name
            cell?.detailTextLabel?.text = location.detail
        }
        
        return cell!
    }

}
