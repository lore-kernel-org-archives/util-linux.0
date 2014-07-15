Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039AbaGOLwc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 07:52:32 -0400
Date: Tue, 15 Jul 2014 13:52:25 +0200
From: Karel Zak <kzak@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: Supporting human parsable journal_dev specifiers
Message-ID: <20140715115225.GY30288@x2.net.home>
References: <20140710142824.GA20753@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140710142824.GA20753@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 10, 2014 at 10:28:24AM -0400, Theodore Ts'o wrote:
> I have a user request that mount be able to interpret the device
> specifier for the journal_dev mount option, so that instead of having
> to type something like
> 
>    mount -o journal_dev=0x0803 ....
> 
> they could unstead use: "journal_dev=/dev/sda3" or even
> "journal_dev=LABEL=ext_journal".  I assume the right way to do this is
> a mount helper?  Or is this something that you would be willing to
> accept as a patch into util-linux?

 I talked about it with Eric Sandeen year ago, and the decision was to
 implement some generic FS independent solution based on variables in
 mount options, something like

     mount -o journal_dev=$(LABEL:<ext_journal_label>)

 (or $LOGUUID for XFS log, etc).

 It's not implemented yet, but I can try it if it's still necessary.
 
> If it is a mount helper, what's the best way to do things?  Simply

 Please, do not use mount helpers (/sbin/mount.<type>), it sucks in
 many ways... it will be better to have a generic solution within
 mount(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
