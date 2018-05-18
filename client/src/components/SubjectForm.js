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
    console.log("handle submit fired")
    let data = {
                 subject: {
                   category_id: this.props.categoryId,
                   name: this.state.value
               }
    };
    console.log(data);

    this.api_call("/subjects.json", data)
      .then(subject => console.log(subject));
    event.preventDefault();
  }

  render() {
    return(
      <div className="subject-form">
        <form onSubmit={this.handleSubmit}>
          <label>
            Name:
            <input type="text" value={this.state.value} onChange={this.handleChange} />
          </label>

          <input type="submit" value="Create Subject" />
        </form>
      </div>
    )
  }
}

export default SubjectForm;