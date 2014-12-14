Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48786 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220AbaLNTuZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:50:25 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 50339208BB
	for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 14:50:25 -0500 (EST)
Message-Id: <1418586625.3874895.202769741.4D89E480@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1418586333-5342-5-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
 <1418586333-5342-5-git-send-email-bensberg@justemail.net>
Subject: Re: [PATCH 5/8] docs: adjust the grammar, text,
 sorting and formatting of logger man page
Date: Sun, 14 Dec 2014 20:50:25 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Sami,

Could you please verify that the rewritten description of --rfc5424 is correct?
I had some doubts about what the original text tried to say.  :)

> +.TP
> +.BR \-\-rfc5424 [ =\fIwithout ]
> +Use the RFC 5424 syslog protocol to submit messages to a remote server.
> +The optional \fIwithout\fR argument can be a comma-separated list of
> +the following values: \fBnotq\fR, \fBnotime\fR, \fBnohost\fR.
> +The \fBnotq\fR value suppresses the time-quality structured data
> +from the submitted message.  (The time-quality information shows whether
> +the local clock was syncronized plus the maximum number of microseconds
> +the timestamp might be off.)  The \fBnotime\fR value (which implies
> +\fBnotq\fR) suppresses the complete sender timestamp that is in
> +ISO-8601 format, including microseconds and timezone.
> +The \fBnohost\fR value suppresses
> +.BR gethostname (2)
> +information from the message header.

Regards,

Benno

-- 
http://www.fastmail.com - Send your email first class

