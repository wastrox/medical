ThinkingSphinx::Index.define :account, :with => :active_record, :delta => ThinkingSphinx::Deltas::DelayedDelta do
	indexes email, :sortable => true
	indexes created_at, sortable: true
end