import React, { Component } from 'react';
import Photo from './Photo';

class SubjectDetail extends Component {
  render() {
    return (
      <div>
        {this.props.subject.photos.map(photo =>
          <Photo photo={photo} subjectName={this.props.subject.subject.name} key={photo.id} />
        )}
      </div>
    )
  }
}

export default SubjectDetail;