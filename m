Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:47831
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342AbaG2QAH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 12:00:07 -0400
Date: Tue, 29 Jul 2014 12:00:04 -0400
Message-Id: <201407291600.s6TG04TH024607@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Karel Zak <kzak@redhat.com>
CC: kerolasa@iki.fi, util-linux@vger.kernel.org
In-reply-to: <20140729074408.GO8533@x2.net.home> (kzak@redhat.com)
Subject: Re: [PATCH] wall: wrap message header when it exceeds 79 characters
References: <1406487666-19466-1-git-send-email-kerolasa@iki.fi> <20140729074408.GO8533@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hmmm...  It seems to me that there's an interface issue.  If you're
*sure* that the message will always be consumed by a human, wrapping
is the nice thing to do.  But if the message will sometimes have to be
extracted by an automaton, write the message without line breaks,
because it's a lot easier for a human to visually reassemble a long
line (wrapped by whatever the display container is) than it is for a
program to discern that two lines are part of the same message.

Dale
