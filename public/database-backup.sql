-- =============================================
-- Cleany Inbox Database Backup
-- Generated: 2026-03-11
-- =============================================

-- Schema Creation
-- =============================================

CREATE TABLE IF NOT EXISTS public.email_actions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  email_sender text NOT NULL,
  email_subject text NOT NULL,
  action text NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.user_preferences (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  sender_pattern text NOT NULL,
  preferred_action text NOT NULL,
  confidence_score double precision NOT NULL DEFAULT 0.5,
  action_count integer NOT NULL DEFAULT 1,
  last_updated timestamp with time zone NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.weekly_summaries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  week_start date NOT NULL,
  emails_processed integer NOT NULL DEFAULT 0,
  emails_kept integer NOT NULL DEFAULT 0,
  emails_deleted integer NOT NULL DEFAULT 0,
  emails_unsubscribed integer NOT NULL DEFAULT 0,
  auto_actions_applied integer NOT NULL DEFAULT 0,
  created_at timestamp with time zone NOT NULL DEFAULT now()
);

-- RLS Policies
-- =============================================

ALTER TABLE public.email_actions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.weekly_summaries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own email actions" ON public.email_actions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own email actions" ON public.email_actions FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own preferences" ON public.user_preferences FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own preferences" ON public.user_preferences FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own preferences" ON public.user_preferences FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can view their own summaries" ON public.weekly_summaries FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert their own summaries" ON public.weekly_summaries FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update their own summaries" ON public.weekly_summaries FOR UPDATE USING (auth.uid() = user_id);

-- Data: email_actions
-- =============================================

INSERT INTO public.email_actions (id, user_id, email_sender, email_subject, action, created_at) VALUES
  ('441da562-ad1a-4f8d-85a7-a5ee6e32e16d', 'e9610706-ea54-4f40-858b-e4a758f82202', 'newsletter@updates.com', 'Weekly Newsletter - Tech Updates', 'delete', '2025-10-18 22:59:40.679755+00'),
  ('8b433b84-e04a-4e10-9483-3ad5d0f63f65', 'e9610706-ea54-4f40-858b-e4a758f82202', 'promo@retailstore.com', '50% OFF Everything - Limited Time!', 'delete', '2025-10-18 22:59:40.679755+00'),
  ('077dcc50-b016-4cc4-bfd6-c46db2bc4c30', 'e9610706-ea54-4f40-858b-e4a758f82202', 'john@company.com', 'Meeting Tomorrow at 10 AM', 'delete', '2025-10-18 22:59:51.567044+00'),
  ('6947005d-218c-4e00-a37c-866ed1c78bbd', 'e9610706-ea54-4f40-858b-e4a758f82202', 'notifications@social.com', 'You have 23 new notifications', 'delete', '2025-10-18 22:59:51.567044+00'),
  ('87c20574-fde7-4f01-a6e8-1285d9bebd16', 'e9610706-ea54-4f40-858b-e4a758f82202', 'billing@service.com', 'Your Invoice for January', 'delete', '2025-10-18 22:59:51.567044+00'),
  ('abc63402-fa38-4784-a1ce-a4264bd06529', 'e9610706-ea54-4f40-858b-e4a758f82202', 'alerts@bank.com', 'Account Security Alert', 'delete', '2025-10-18 22:59:51.567044+00'),
  ('5e3c40ee-6b5d-4ae5-8594-9379efa8e283', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'PodSnacks <info@podsnacks.org>', 'Your Daily News Podcast Summaries', 'unsubscribe', '2025-10-20 03:22:18.406468+00'),
  ('e9243111-fab0-40e4-8c82-eb2d4ba8ab50', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"4D Copywriting Community (Skool)" <noreply@skool.com>', '1 event happening tomorrow', 'unsubscribe', '2025-10-20 03:22:18.406468+00'),
  ('bbf35338-383e-490b-a882-125adb334237', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"Sarah Fay | Substack Writers at Work" <serialize@substack.com>', 'Spooky Substack Pep Talk', 'unsubscribe', '2025-10-20 03:22:18.406468+00'),
  ('6ef5bcf7-360d-4cef-92e4-0b91ea39e496', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'Fraser <fraser@microsaasmba.com>', 'Did you see this?', 'unsubscribe', '2025-10-20 03:22:18.406468+00'),
  ('7d07f557-15df-4792-a9b3-a74c84c2c3d9', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'Tyson 4D <tyson@tyson4d.com>', 'Joy x 1st paying AI client', 'unsubscribe', '2025-10-20 03:22:18.406468+00'),
  ('5c1dab5d-701f-4b26-8182-e4c60880748d', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'PodSnacks <info@podsnacks.org>', 'Your Daily News Podcast Summaries', 'unsubscribe', '2025-10-20 03:22:18.482088+00'),
  ('c7494eba-5526-44c6-b9a8-a96892b3a811', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"4D Copywriting Community (Skool)" <noreply@skool.com>', '1 event happening tomorrow', 'unsubscribe', '2025-10-20 03:22:18.482088+00'),
  ('78975b3d-e988-497b-8777-d747571570d6', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"Sarah Fay | Substack Writers at Work" <serialize@substack.com>', 'Spooky Substack Pep Talk', 'unsubscribe', '2025-10-20 03:22:18.482088+00'),
  ('3ba7662f-d4db-4922-944d-eb81e4014f47', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'Fraser <fraser@microsaasmba.com>', 'Did you see this?', 'unsubscribe', '2025-10-20 03:22:18.482088+00'),
  ('eccc6488-f6f0-471a-a960-f67dbabf5fec', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'Tyson 4D <tyson@tyson4d.com>', 'Joy x 1st paying AI client', 'unsubscribe', '2025-10-20 03:22:18.482088+00'),
  ('f8ded54f-26dd-42fe-b0f7-9c0f44c1e4a0', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'PodSnacks <info@podsnacks.org>', 'Your Daily News Podcast Summaries', 'unsubscribe', '2025-10-20 03:22:18.609+00'),
  ('29a90d24-d516-4fab-8121-23491cef58c7', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"4D Copywriting Community (Skool)" <noreply@skool.com>', '1 event happening tomorrow', 'unsubscribe', '2025-10-20 03:22:18.609+00'),
  ('8f153a04-6e93-4d9a-965a-5c7f7053eb13', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '"Sarah Fay | Substack Writers at Work" <serialize@substack.com>', 'Spooky Substack Pep Talk', 'unsubscribe', '2025-10-20 03:22:18.609+00'),
  ('60961bab-e256-4835-ae88-1f85a9c82af8', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'Fraser <fraser@microsaasmba.com>', 'Did you see this?', 'unsubscribe', '2025-10-20 03:22:18.609+00');

-- Data: user_preferences
-- =============================================

INSERT INTO public.user_preferences (id, user_id, sender_pattern, preferred_action, confidence_score, action_count, last_updated) VALUES
  ('972d6fea-fe34-4e72-ad16-1839a7ae4f3a', 'e9610706-ea54-4f40-858b-e4a758f82202', 'updates.com', 'delete', 0.6, 1, '2025-10-18 22:59:40.992907+00'),
  ('d7ea52f0-e025-4062-9357-d6bd1460e977', 'e9610706-ea54-4f40-858b-e4a758f82202', 'retailstore.com', 'delete', 0.6, 1, '2025-10-18 22:59:41.263725+00'),
  ('3ff64187-1e02-4813-bcd8-efad66c29c25', 'e9610706-ea54-4f40-858b-e4a758f82202', 'company.com', 'delete', 0.6, 1, '2025-10-18 22:59:51.849263+00'),
  ('fb31d70a-18b1-472f-9d86-0ec6020cee6f', 'e9610706-ea54-4f40-858b-e4a758f82202', 'social.com', 'delete', 0.6, 1, '2025-10-18 22:59:52.155791+00'),
  ('c0935f5e-9fb2-400f-a1dc-962e0054eaec', 'e9610706-ea54-4f40-858b-e4a758f82202', 'service.com', 'delete', 0.6, 1, '2025-10-18 22:59:52.399763+00'),
  ('ba5723e3-e938-4d0b-94cd-86170d5493b4', 'e9610706-ea54-4f40-858b-e4a758f82202', 'bank.com', 'delete', 0.6, 1, '2025-10-18 22:59:52.633487+00'),
  ('8b3cb910-c078-43b8-879d-0b89e74e07d7', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'podsnacks.org>', 'unsubscribe', 1, 8, '2025-10-20 03:22:42.88+00'),
  ('2ea0618e-21ba-4ff6-a47d-6015c8832e58', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'microsaasmba.com>', 'unsubscribe', 1, 8, '2025-10-20 03:22:43.594+00'),
  ('be95c33f-014a-4fcf-a64c-e65d45dee480', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'tyson4d.com>', 'unsubscribe', 1, 8, '2025-10-20 03:22:43.836+00'),
  ('010c4166-c1d5-40b7-afba-e3b9e63dfd59', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'substack.com>', 'unsubscribe', 1, 9, '2025-10-20 03:27:48.116+00'),
  ('a3c47d66-5e47-4c54-b31d-05aad4a04a7d', '90414ca0-2700-41de-a1e9-e6b0fd33d173', 'skool.com>', 'delete', 0.85, 8, '2025-10-20 23:00:13.049+00');

-- Data: weekly_summaries
-- =============================================

INSERT INTO public.weekly_summaries (id, user_id, week_start, emails_processed, emails_kept, emails_deleted, emails_unsubscribed, auto_actions_applied, created_at) VALUES
  ('6ec90c14-dd31-4754-98bb-99ded39c05f7', 'e9610706-ea54-4f40-858b-e4a758f82202', '2025-10-12', 6, 0, 6, 0, 0, '2025-10-18 22:59:41.513155+00'),
  ('bdc45199-281a-40df-9541-e25ef7da4a31', '90414ca0-2700-41de-a1e9-e6b0fd33d173', '2025-10-19', 42, 0, 1, 41, 0, '2025-10-20 03:22:19.963669+00');
