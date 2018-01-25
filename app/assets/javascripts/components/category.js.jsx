var Category = createReactClass({
  propTypes: {
    id: PropTypes.number,
    name: PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Id: {this.props.id}</div>
        <div>Name: {this.props.name}</div>
      </div>
    );
  }
});

