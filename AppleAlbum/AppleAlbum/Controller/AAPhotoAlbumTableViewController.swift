//
//  AAPhotoAlbumTableViewController.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import UIKit
import SafariServices


class AAPhotoAlbumTableViewController: UITableViewController {

  var albumList: [AAAlbum] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 96.0
    tableView.registerNib(cellIdentifier: AACellIdentifierType.AlbumTableCell)
    navigationItem.leftBarButtonItem = editButtonItem
    refreshAlbumList()
  }

  func refreshAlbumList() {
    AAWebServiceManager.fetchAlbumList { [weak self] (response) in
      guard let weakSelf = self else { return }

      if response.isFailure {
        print("Error == \(String(describing: response.error))")
      } else {

        if let albumList = response.value {
          print("Success == \(albumList.count) album fetched :)")
          weakSelf.albumList = albumList
          DispatchQueue.main.async {
            weakSelf.tableView.reloadData()
            weakSelf.endRefreshControlRefreshing()
          }
        }
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Refresh Control

extension AAPhotoAlbumTableViewController {

  @IBAction func refresh(_ sender: UIRefreshControl) {
    refreshAlbumList()
  }

  func endRefreshControlRefreshing() {
    if let refreshControl = refreshControl {
      if refreshControl.isRefreshing {
        refreshControl.endRefreshing()
      }
    }
  }
}

// MARK: - Table view data source & delegate

extension AAPhotoAlbumTableViewController{

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albumList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if let albumCell = tableView.dequeueReusableCell(withIdentifier: AACellIdentifierType.AlbumTableCell.rawValue, for: indexPath) as? AAAlbumTableCell {
      let selectedRow = indexPath.row
      if albumList.count > selectedRow {
        albumCell.configure(album: albumList[selectedRow])
      }
      return albumCell
    }
    return UITableViewCell()
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      albumList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    albumList.swapAt(fromIndexPath.row, to.row)
  }

  override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    pushArtistDetailViewControllerForAlbum(albumList[indexPath.row])
  }
}

extension AAPhotoAlbumTableViewController : SFSafariViewControllerDelegate {

  func pushArtistDetailViewControllerForAlbum(_ album :AAAlbum) {
    if let artistPageURl = album.artistPageUrl,
      let url = NSURL(string: "https://www.apple.com") {
      let safariViewController = SFSafariViewController(url: url as URL)
      safariViewController.delegate = self
      present(safariViewController, animated: true, completion: nil)
    }
  }

  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    dismiss(animated: true, completion: nil)
  }

}
