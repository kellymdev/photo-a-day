import React, { Component } from 'react';
import Subject from './Subject';
import SubjectDetail from './SubjectDetail';

class CategoryDetail extends Component {
  constructor() {
    super();
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick = (id) => {
    this.props.onClick(id);
  }

  render() {
    return (
      <div>
        <h2 className="category-header">{this.props.category.category.name}</h2>

        <div className="subject-list">
          <ul className="subject-menu">
            {this.props.category.subjects.map(subject =>
              <Subject subject={subject} key={subject.id} onClick={this.handleClick} selected={this.props.subject ? subject.id === this.props.subject.subject.id : false} />
            )}
          </ul>
        </div>

        { this.props.subject ? (
          <div className="subject-detail">
            <SubjectDetail subject={this.props.subject} />
          </div>
        ) : (
          <div></div>
        )}
      </div>
    )
  }
}

export default CategoryDetail;