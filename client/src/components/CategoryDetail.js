import React, { Component } from 'react';

class CategoryDetail extends Component {
  render() {
    console.log(this.props.category.category)
    console.log(this.props.category.subjects)

    return (
      <div>
        <h2>{this.props.category.category.name}</h2>
      </div>
    )
  }
}

export default CategoryDetail;