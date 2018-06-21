import React, { Component } from 'react';
import Photo from './Photo';
import PhotoForm from './PhotoForm';

class SubjectDetail extends Component {
  constructor() {
    super();
    this.state = {showForm: false};
  }

  displayPhotoForm = () => {
    this.setState({showForm: true});
  }

  hidePhotoForm = (photo) => {
    this.setState({showForm: false});
    this.props.onSubmit(photo.category.id);
  }

  render() {
    return (
      <div>
        <div className="add-photo">
          {this.state.showForm ? (
            <PhotoForm subjectId={this.props.subject.subject.id} onSubmit={this.hidePhotoForm} />
          ) : (
            <button className="add-photo-button" onClick={this.displayPhotoForm}>Add Photo</button>
          )}
        </div>

        <div className="photos">
          {this.props.subject.photos.map(photo =>
            <Photo photo={photo} subjectName={this.props.subject.subject.name} key={photo.id} />
          )}
        </div>
      </div>
    )
  }
}

export default SubjectDetail;