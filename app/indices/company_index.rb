ThinkingSphinx::Index.define :company, :with => :active_record, :delta => ThinkingSphinx::Deltas::DelayedDelta do
	indexes name, :sortable => true
	indexes created_at, sortable: true
	where "companies.state IN ('published', 'vip')"
end