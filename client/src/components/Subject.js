import React, { Component } from 'react';

class Subject extends Component {
  handleClick = () => {
    this.props.onClick(this.props.subject.id)
  }

  render() {
    return (
      <div>
        <p className="subject-name" onClick={this.handleClick}>{this.props.subject.name}</p>
      </div>
    )
  }
}

export default Subject;