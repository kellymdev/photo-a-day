import React, { Component } from 'react';

class PhotoForm extends Component {
  constructor() {
    super();
    this.state = {date: '',
                  imageUrl: '',
                  notes: '',
                  errors: null};
    this.handleDateChange = this.handleDateChange.bind(this);
    this.handleImageUrlChange = this.handleImageUrlChange.bind(this);
    this.handleNotesChange = this.handleNotesChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.resetState = this.resetState.bind(this);
    this.validateDate = this.validateDate.bind(this);
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
    let url = null

    if (this.state.imageUrl.size > 0) {
      url = this.state.imageUrl
    }

    let data = {
                 photo: {
                  date: this.state.date,
                  image_url: url,
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
                   notes: '',
                   errors: null});
  }

  validateDate = () => {
    if (!this.state.date) {
      return false;
    }

    if (this.validDate(this.state.date)) {
      this.setState({errors: null});
    } else {
      this.setState({errors: 'Date is invalid'});
    }
  }

  validDate = (dateString) => {
    let dateRegex = /(\d{4})-(\d\d?)-(\d\d?)/;
    let dateArray = dateString.match(dateRegex);

    if (!!dateArray) {
      return false;
    }

    let year = parseInt(dateArray[1], 10);
    let month = parseInt(dateArray[2], 10);
    let day = parseInt(dateArray[3], 10);

    return this.validYear(year) && this.validMonth(month) && this.validDay(day, month);
  }

  validYear = (year) => {
    return year >= 2000 && year <= 9999;
  }

  validMonth = (month) => {
    return month >= 1 && month <= 12;
  }

  validDay = (day, month) => {
    if (day < 1) {
      return false
    }

    if ([1, 3, 5, 7, 8, 10, 12].includes(month)) { // 31 days
      return day <= 31
    } else if ([4, 6, 9, 11].includes(month)) { // 30 days
      return day <= 30
    } else if (month === 2) { // 28 or 29 days
      return day <= 29
    }
  }

  render() {
    return(
      <div className="photo-form">
        <form onSubmit={this.handleSubmit}>
          <div className="errors">
            {this.state.errors}
          </div>

          <label>
            Date:
            <input type="text" placeholder="YYYY-MM-DD" value={this.state.date} onChange={this.handleDateChange} onBlur={this.validateDate} />
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