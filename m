Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:53367 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab3AVX1W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:22 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so2142065wgb.4
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/14] docs: usage function and gettext
Date: Tue, 22 Jan 2013 23:27:00 +0000
Message-Id: <1358897233-6676-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I made following survey which was sent to all email addresses in po/
directory that had the on-going millenium as time when translator had
been active.

  There are two quite common styles to write a command usage print out,
  which one you prefer?

  1. Each option as separated translatable string.	18 votes
  2. Or the whole thing as one big output.		 1 vote
  3. No preference.					 1 vote

The questionaire had also free text field asking 'Why do you prefer
that?', and here are the answers.

  [Separately] It is easier to follow changes with the translations.  If
  you change only one line or two, the big string would change to fuzzy
  and I have to check the whole thing to see what was changed in the
  original.  If the changed line is a single string, the string to check
  is a lot shorter.

  [No preference] Usually, if there is no reason to separate strings,
  better keep them together so that the context is obvious.  In the case at
  hand, it might help if in some language e.g.  one translated line is too
  wide for the screen.  This is unlikely, but...  OTOH, with this solution,
  if you change one string the whole translation will be discarded until a
  translator comes and updates it...

  [Separately] It may be a bit harder to get the formatting right, but it
  is much easier in maintenance.  With one option changing, the
  translator immediately sees the spot.  And even with a lazy translator,
  program author will have all the options translated that have not
  changed at all.

  [Separately] First one would be more in elegant I believe

  [Separately] I prefer to have them separately because they don't form a
  single text paragraph.  In other words, they can be translated
  separately because they are complete and separate "sentences".  Of
  course consistency of format and word choices need to be taken care of,
  but the fact that the messages appear next to each other in the PO file
  should be enough.  Also if the options are not translated separately,
  adding or editing one option causes the translation of all options to
  become fuzzy and if for some reason it isn't checked before next
  release (happens sometimes), all of them will show untranslated to the
  user.

  [Separately] Translations are a lot easier to update that way.  If an
  option is added, removed or changed, only a small amount of text
  becomes fuzzy.  If everything is in one big output, a lot of text
  becomes fuzzy, and you have to read a lot more text to discover what
  exactly changed.

  [Separately] When updating a fuzzy translation, with one big output
  it's very tedious and error-prone to find out the reason for fuzziness,
  i.e.  what actually has changed in the msgid.

  [Separately] Way easier to translate, and especially to spot
  translation updates when one string gets removed, added or modified.

  [Separately] Makes translation memory more efficient.  Some hard terms
  in the list don't prevent translation of the whole block.  Actually the
  beginning of the strings don't need any translation ta all before []
  part.  Information about the context can be provided in comments or the
  context parameter.

  [Separately] Please consider the case when a part of string, (= msgid)
  is changed.  It is marked as fuzzy in the .po files, we translators
  have to check whole sentences for the difference between it and
  previous version.

  [Separately] Every sentence must be a separate translation unit.

  [One big output] for performance to ouput strings

  [Separately] In the second case, if only one option changes (or a new
  one is added), the translator will see as if all of the options
  changed, having to find out which one of them is really new or has
  actually changed.  Also, if the translator has had no time to update
  the string, only one of the options will be shown in the original
  language (which is arguably ugly, but better than nothing for many
  users).

  [Separately] It's easier to translate the options separately using
  translation memory.

  [Separately] Easier to separate and see changes

  [Separately] more translator friendly

  [Separately] From the user POV I found the separeted version more
  interesting because if a maintainer can't update the translation fast
  enough between releases the user will still get the current translated
  string with the new ones untraslated.  From the translator POV the big
  output will give more context information as one can see the whole
  command options.  With a new string added while the rest is translated
  having some context can be more difficult.

  [Separately] Additions to the list or changes to one options means you
  don't have to check all lines each time.

So unless you have very, _very_ good reason you should not output all
usage as one big table.  This implies also that when large usage output
is changed it should be split to small hunks.  That may be a bit more
work once, but the next change will pay the extrawork off so never
hesitate when splitting.

Reference: http://www.surveymonkey.com/s/QKZ75HK
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/howto-usage-function.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 1944bb7..371ff32 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -105,9 +105,19 @@ bellow what that means.
 	fprintf(out, _(" -x[=<foo>]  default foo is %s"), x);
 	fputs(       _(" -y          some text"), out);
 
-The usage output should be split to manageable chunks, in practice one or
-few lines.
-
+Be nice to translators. One gettext entry should be one option, no more,
+no less. For example:
+
+	fputs(_(" --you-there  be nice\n"), out);
+	fputs(_(" -2 <whom>    translators\n"), out);
+	fputs(_(" -t, --hey    are doing job that we probably cannot,"
+		"                or how is your klingon?\n"), out);
+
+When existing usage output is changed, and it happens to be one big
+output, split it to chunks size of an option.  The extra work for
+translators will pay off at the time of the next change when they do not
+need to search from fuzzy markup what has changed, where, how, and was it
+the only change.
 
 Synopsis
 --------
-- 
1.8.1.1

