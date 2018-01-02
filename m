Return-Path: elseifthen@gmx.com
Subject: [v3 PATCH 00/11] Pull Request - changelog
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Date: Tue, 2 Jan 2018 09:53:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


In my last post I suggested a path to implementing Karel's
idea of having complementary options --julian and --gregorian
that output their respective calendar systems exclusively.
IMO, having the capability for Julian calendar output is a
nice addition; and making proleptic Gregorian the default
output is the correct choice (reasons are given in the commit
log).

Having not received any reply, I went ahead with the
implementation, with one change involving Karel's original
request for volunteers. Specifically, the first and last bullet
points; which where:

* keep the current default "British Empire" behavior (Gregorian since
  September 1752)

* later (after warning in release notes) we can make --gregorian as
  the default

During implementation I considered these issues:

* to do that we'd be creating two new options --iso, and an
  alias --gregorian; these would become non-functional once
  they were made the default. Just like the current situation
  with --one and --sunday.

* this change is unlikely to affect downstream maintainers

* end users are the ones that may be caught out by it

* a release note warning that some future version of cal(1)
  will change the default output is unlikely to reach the end
  users.

So I think it would be better to just rip-the-band-aid-off, as
they say, and make it the default straight away. I added a
prominent note near the top of the man page, and of course do
the same in the release notes highlights.

This patch set breaks cal(1) tests. I will look at fixing them
if/when it is accepted.

Indirectly, the current tests are broken. I think this
supports some of the changes in this patch set:

The tests author seemed to believe that the -1 and -s options
actually do something, despite the 'expected' output showing
otherwise. While testing this patch set I thought the same
thing; I tried to figure out what these two options do; which
is nothing. I think this is good evidence to support removing
them.

The tests author also seems to believe that the -j option
switches from the Gregorian calendar system to the Julian
calendar system. Making comments to that affect and using it
in tests involving the year 1752; a year which uses both
calendar systems. I think this is good evidence to support
renaming --julian to --ordinal.

If developers for the project are being confused by these
options, than what chance do end users have? So that's my case
for making these changes.

Also while pounding on cal(1), to see if these patches broke
anything, I found a few other issues and fixed them as well.
The man page was quite sparse, for example having no explanation
for the -w argument, so rewrote much of it.

v2 to v3 changelog
* make proleptic Gregorian the default
* extensive man page updates
* rename --julian to --ordinal
* add private (for now) --caesar option for exclusive Julian calendar
* allow -w to accept its argument
* update mutually exclusive options
* add short versions for the new options
* remove non-functional options
* fix broken week calculations

v1 to v2 changelog
 * fix typo in v1
 * move REFORMATION_YEAR to the control struct
 * add more about the --1752-reform option to man page
 * add a second patch with minor style and wording changes


The following changes since commit 43afa84581de8984aa00ef2e9208198929f72ddf:

  lib/mbsalign: encode \x to \xecx (2017-12-20 13:01:43 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 171229

for you to fetch changes up to 22540b0a23283925ce4b13c13839e4dd2172bd1d:

  cal: fix week calculations for --1752-reform (2018-01-01 21:25:16 -0500)

----------------------------------------------------------------
J William Piggott (11):
      cal: change default output format
      cal: change reformation to reform
      cal: update man page and usage()
      cal: rename --julian to --ordinal
      cal: add private --caesar option
      cal: make -w accept its optional argument
      cal: update mutually exclusive options
      cal: add short versions of new options
      cal: remove the non-functional options
      cal: fix first week calculation
      cal: fix week calculations for --1752-reform

 Documentation/deprecated.txt |   6 ++
 misc-utils/cal.1             | 164 ++++++++++++++++++++++------------
 misc-utils/cal.c             | 208 ++++++++++++++++++++++++-------------------
 3 files changed, 233 insertions(+), 145 deletions(-)
