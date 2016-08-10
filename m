Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38406 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558AbcHJSDq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Aug 2016 14:03:46 -0400
Date: Wed, 10 Aug 2016 14:38:59 +0200
From: Jan Kara <jack@suse.cz>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sbrabec@suse.cz, kzak@redhat.com, util-linux@vger.kernel.org
Subject: UDF label change since commit 2f2730bc77c9
Message-ID: <20160810123859.GA31140@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

we have noticed that since commit 2f2730bc77c9 "libblkid: udf: Fix reading
LABEL, add support for UUID and other udf identifiers" some volumes have
changed labels which are reported by blkid. See [1] for an example. This is
because that commit changed what is used for the label - previously we have
used 'ident' in the Primary Volume Descriptor, and after that commit we use
Logical Volume ID.

I think it would be better to keep consistency with older util-linux
releases (e.g. valid /etc/fstab that uses labels may be broken by this
change) but I'm not sure whether there is a point once the new behavior
has been released in the util-linux release. But still I wanted to raise
this since I'm not sure how much util-linux cares about these changes and
also so that people are aware of the change...

								Honza

[1] https://bugzilla.suse.com/show_bug.cgi?id=983165

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
