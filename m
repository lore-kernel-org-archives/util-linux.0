Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47000 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771AbbBJKwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 05:52:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1AAqG1n024835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Tue, 10 Feb 2015 05:52:16 -0500
Date: Tue, 10 Feb 2015 11:52:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Fridolin Pokorny <fpokorny@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libmount: MNT_OMODE_FORCE usage
Message-ID: <20150210105214.GE19845@ws.net.home>
References: <1423234521.24479.9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423234521.24479.9.camel@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 06, 2015 at 03:55:21PM +0100, Fridolin Pokorny wrote:
> I have found out that libmount does not respect MNT_OMODE_FORCE mode.
> I don't see any usage in sources

 This is not true. It's used for example by MNT_OMODE_USER (mount by
 non-root user).

> and libmount does not respect this mode
> when calling library functions.

 I don't think so, the MNT_OMODE_FORCE flag is extension, no
 replacement to MNT_OMODE_{FSTAB,MTAB}.

 The default mount(8) behavior is not to read fstab if mount source and target
 are specified, this feature is possible to disable by 
 
    MNT_OMODE_FORCE | MNT_OMODE_FSTAB

 I guess you forgot to use MNT_OMODE_FSTAB (or/and MNT_OMODE_MTAB),
 alone MNT_OMODE_FORCE does not make sense.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
