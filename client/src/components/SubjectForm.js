import React, { Component } from 'react';

class SubjectForm extends Component {
  constructor() {
    super();
    this.state = {value: ''};
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
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

  handleChange = (event) => {
    this.setState({value: event.target.value});
  }

  handleSubmit = (event) => {
    let data = {
                 subject: {
                   category_id: this.props.categoryId,
                   name: this.state.value
                 }
               };

    this.api_call("/subjects.json", data)
      .then(subject => this.props.onSubmit(subject));
    event.preventDefault();

    this.setState({value: ''});
  }

  render() {
    return(
      <div className="subject-form">
        <form onSubmit={this.handleSubmit}>
          <label>Name: </label>
          <input type="text" className="form-field" value={this.state.value} onChange={this.handleChange} />

          <input type="submit" value="Create Subject" />
        </form>
      </div>
    )
  }
}

export default SubjectForm;