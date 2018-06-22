import React, { Component } from 'react';

class EditPhotoForm extends Component {
  constructor(props) {
    super(props);
    this.state = {date: this.props.date || '',
                  imageUrl: this.props.imageUrl || '',
                  notes: this.props.notes || '',
                  errors: null};
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleDateChange = this.handleDateChange.bind(this);
    this.handleUrlChange = this.handleUrlChange.bind(this);
    this.handleNotesChange = this.handleNotesChange.bind(this);
  }

  api_call(url, data) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        body: JSON.stringify(data),
        credentials: 'same-origin',
        headers: {
          "content-type": "application/json"
        },
        method: 'PUT',
        mode: 'cors'
      }).then(response => response.json())
        .then(json => resolve(json))
        .catch(error => reject(error))
    })
  }

  handleDateChange = (event) => {
    this.setState({date: event.target.value});
  }

  handleUrlChange = (event) => {
    this.setState({imageUrl: event.target.value});
  }

  handleNotesChange = (event) => {
    this.setState({notes: event.target.value});
  }

  handleSubmit = (event) => {
    if (!this.state.date) {
      this.setState({errors: 'Date is required'});
      return false;
    }

    let url = null;

    if (this.state.imageUrl.size > 0) {
      url = this.state.imageUrl;
    }

    let data = {
                 photo: {
                   date: this.state.date,
                   image_url: url,
                   notes: this.state.notes
                 }
               };
    this.api_call("subjects/" + this.props.subjectId + "/photos/" + this.props.photoId + ".json", data)
      .then(photo => this.props.onSubmit(photo));
    event.preventDefault();
  }

  render() {
    return(
      <div className="edit-photo-form">
        <form onSubmit={this.handleSubmit}>
          <div className="errors">
            {this.state.errors}
          </div>

          <label>Date: </label>
          <input type="text" className="form-field" placeholder="YYYY-MM-DD" value={this.state.date} onChange={this.handleDateChange} />

          <label>Image Url: </label>
          <input type="text" className="form-field" value={this.state.imageUrl} onChange={this.handleUrlChange} />

          <label>Notes: </label>
          <input type="text" className="form-field" value={this.state.notes} onChange={this.handleNotesChange} />

          <input type="submit" value="Edit Photo" />
        </form>
      </div>
    )
  }
}

export default EditPhotoForm;