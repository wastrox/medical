ThinkingSphinx::Index.define :vacancy, :with => :active_record, :delta => ThinkingSphinx::Deltas::DelayedDelta do
	indexes name, :sortable => true
	indexes publicated_at, sortable: true
	indexes city
	where "vacancies.state IN ('published', 'hot')"
end