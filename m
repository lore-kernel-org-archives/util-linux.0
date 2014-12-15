Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:50662 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaLOTDQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Dec 2014 14:03:16 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so15573929wgh.2
        for <util-linux@vger.kernel.org>; Mon, 15 Dec 2014 11:03:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1418586625.3874895.202769741.4D89E480@webmail.messagingengine.com>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
	<1418586333-5342-5-git-send-email-bensberg@justemail.net>
	<1418586625.3874895.202769741.4D89E480@webmail.messagingengine.com>
Date: Mon, 15 Dec 2014 19:03:14 +0000
Message-ID: <CAG27Bk38fVqQpkNKJfszeMk94DaGUWv_uux47NN1SOKRUBo2yg@mail.gmail.com>
Subject: Re: [PATCH 5/8] docs: adjust the grammar, text, sorting and
 formatting of logger man page
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 December 2014 at 19:50, Benno Schulenberg <bensberg@justemail.net> wrote:
> Could you please verify that the rewritten description of --rfc5424 is correct?
> I had some doubts about what the original text tried to say.  :)
>
>> +.TP
>> +.BR \-\-rfc5424 [ =\fIwithout ]
>> +Use the RFC 5424 syslog protocol to submit messages to a remote server.
>> +The optional \fIwithout\fR argument can be a comma-separated list of
>> +the following values: \fBnotq\fR, \fBnotime\fR, \fBnohost\fR.
>> +The \fBnotq\fR value suppresses the time-quality structured data
>> +from the submitted message.  (The time-quality information shows whether
>> +the local clock was syncronized plus the maximum number of microseconds
>> +the timestamp might be off.)  The \fBnotime\fR value (which implies
>> +\fBnotq\fR) suppresses the complete sender timestamp that is in
>> +ISO-8601 format, including microseconds and timezone.
>> +The \fBnohost\fR value suppresses
>> +.BR gethostname (2)
>> +information from the message header.

Hi Benno,

Yes I did try to tell about that, but in usual in-understandable way ,-)

I'm not sure if the logger(1) manual should emphasis more that the
hostname is the same as printout of hostname(1) command, rather than
DNS name of the server sending the name. Configurations where they are
not in sync may cause some head scratching & swearing for system
admins (especially if hostname(1) output matches with unrelated DNS
name).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
