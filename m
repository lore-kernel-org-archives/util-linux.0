Return-Path: elseifthen@gmx.com
Message-ID: <5449BD0F.2070906@gmx.com>
Date: Thu, 23 Oct 2014 22:44:31 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 0/5] hwclock: clean up messages
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

This patch set cleans up various message output.
It contains cosmetic changes only.

J William Piggott (5):
  hwclock: Remove newline from 'date' debug output
  hwclock: clean up message periods/full stops
  hwclock: add message line breaks
  hwclock: Fix --date debug messages
  hwclock: version prints out of order

 sys-utils/hwclock.c | 145 ++++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 72 deletions(-)
