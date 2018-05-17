import React, { Component } from 'react';
import Subject from './Subject';

class CategoryDetail extends Component {
  render() {
    console.log(this.props.category.category)
    console.log(this.props.category.subjects)

    return (
      <div>
        <h2>{this.props.category.category.name}</h2>

        {this.props.category.subjects.map(subject =>
          <Subject subject={subject} key={subject.id} />
        )}
      </div>
    )
  }
}

export default CategoryDetail;