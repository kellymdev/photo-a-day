import React, { Component } from 'react';

class Subject extends Component {
  render() {
    return (
      <div>
        <p className="subject-name">{this.props.subject.name}</p>
      </div>
    )
  }
}

export default Subject;