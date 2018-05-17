import React, { Component } from 'react';
import Subject from './Subject';
import SubjectDetail from './SubjectDetail';

class CategoryDetail extends Component {
  constructor() {
    super()
    this.state = {selectedSubject: null};
    this.getSubject = this.getSubject.bind(this);
  }

  api_call(url) {
    return new Promise((resolve, reject) => {
      window.fetch(url, {
        headers: {
          "Content-Type": "application/json"
        }
      }).then(response => response.json())
        .then(json => resolve(json))
        .catch(error => reject(error))
    })
  }

  getSubject = (id) => {
    this.api_call('/subjects/' + id + '.json')
      .then(subject =>
        this.setState({selectedSubject: subject})
      )
  }

  render() {
    return (
      <div>
        <h2 className="category-header">{this.props.category.category.name}</h2>

        {this.props.category.subjects.map(subject =>
          <Subject subject={subject} key={subject.id} onClick={this.getSubject} />
        )}

        {this.state.selectedSubject !== null ? (
          <div className="subject-detail">
            <SubjectDetail subject={this.state.selectedSubject} />
          </div>
        ) : (
          <div></div>
        )}
      </div>
    )
  }
}

export default CategoryDetail;