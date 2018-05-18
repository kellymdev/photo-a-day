import React, { Component } from 'react';

class SubjectForm extends Component {
  constructor() {
    super();
    this.state = {value: null};
  }

  render() {
    return(
      <div className="subject-form">
        <form>
          <label>
            Name:
            <input type="text" value={this.state.value} />
          </label>

          <input type="submit" value="Create Subject" />
        </form>
      </div>
    )
  }
}

export default SubjectForm;