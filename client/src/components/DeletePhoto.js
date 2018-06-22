import React, { Component } from 'react';

class DeletePhoto extends Component {
  constructor() {
    super();
    this.handleDelete = this.handleDelete.bind(this);
  }

  api_call(url) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        credentials: 'same-origin',
        headers: {
          "content-type": "application/json"
        },
        method: 'DELETE',
        mode: 'cors'
      }).then(response => response.json())
        .then(json => resolve(json))
        .catch(error => reject(error))
    })
  }

  handleDelete = (event) => {
    this.api_call("/subjects/" + this.props.subjectId + "/photos/" + this.props.photoId + '.json')
      .then(response => this.props.onClick(response.category_id));
  }

  render() {
    return (
      <button type="button" className="delete-photo" onClick={this.handleDelete}>Delete Photo</button>
    )
  }
}

export default DeletePhoto;