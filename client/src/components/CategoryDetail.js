import React, { Component } from 'react';
import Subject from './Subject';
import SubjectDetail from './SubjectDetail';
import SubjectForm from './SubjectForm';

class CategoryDetail extends Component {
  constructor() {
    super();
    this.state = {showForm: false};
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick = (id) => {
    this.props.onClick(id);
  }

  displaySubjectForm = () => {
    this.setState({showForm: true});
  }

  hideSubjectForm = (subject) => {
    this.setState({showForm: false});
  }

  render() {
    return (
      <div>
        <h2 className="category-header">{this.props.category.category.name}</h2>

        <div className = "add-subject">
          {this.state.showForm ? (
            <SubjectForm categoryId={this.props.category.category.id} onSubmit={this.hideSubjectForm} />
          ) : (
            <button className="add-subject-button" onClick={this.displaySubjectForm}>Add Subject</button>
          )}
        </div>

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