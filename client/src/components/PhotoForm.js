import React, { Component } from 'react';

class PhotoForm extends Component {
  constructor() {
    super();
    this.state = {date: '',
                  imageUrl: '',
                  notes: ''};
    this.handleDateChange = this.handleDateChange.bind(this);
    this.handleImageUrlChange = this.handleImageUrlChange.bind(this);
    this.handleNotesChange = this.handleNotesChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.resetState = this.resetState.bind(this);
  }

  api_call(url, data) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        body: JSON.stringify(data),
        credentials: 'same-origin',
        headers: {
          "content-type": "application/json"
        },
        method: 'POST',
        mode: 'cors'
      }).then(response => response.json())
        .then(json => resolve(json))
        .catch(error => reject(error))
    })
  }

  handleDateChange = (event) => {
    this.setState({date: event.target.value});
  }

  handleImageUrlChange = (event) => {
    this.setState({imageUrl: event.target.value});
  }

  handleNotesChange = (event) => {
    this.setState({notes: event.target.value});
  }

  handleSubmit = (event) => {
    let data = {
                 photo: {
                  date: this.state.date,
                  image_url: this.state.imageUrl,
                  notes: this.state.notes
                 }
               };
    this.api_call("/subjects/" + this.props.subjectId + "/photos.json", data)
      .then(photo => this.props.onSubmit(photo));
    event.preventDefault();

    this.resetState();
  }

  resetState = () => {
    this.setState({date: '',
                   imageUrl: '',
                   notes: ''});
  }

  render() {
    return(
      <div className="photo-form">
        <form onSubmit={this.handleSubmit}>
          <label>
            Date:
            <input type="text" value={this.state.date} onChange={this.handleDateChange} />
          </label>

          <label>
            Image Url:
            <input type="text" value={this.state.imageUrl} onChange={this.handleImageUrlChange} />
          </label>

          <label>
            Notes:
            <input type="text" value={this.state.notes} onChange={this.handleNotesChange} />
          </label>

          <input type="submit" value="Create Photo" />
        </form>
      </div>
    )
  }
}

export default PhotoForm;