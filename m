Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbaDIHnq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 03:43:46 -0400
Date: Wed, 9 Apr 2014 09:43:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: check for ext* is deeply broken
Message-ID: <20140409074342.GO22126@x2.net.home>
References: <1396993958.14732.144.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396993958.14732.144.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 08, 2014 at 11:52:38PM +0200, Stanislav Brabec wrote:
> It implies, that all subsequent logic expressions in probe_ext* are
> inconsistent and makes no sense as well. Additionally, I guess that some
> of these checks are incorrect per self. (As long as only one
> probe_ext?() returns success, then blkid returns at least something.)

commit a1ca32fb3862ccac7275d6b342805b6d99f20e39
Author: Lukas Czerner <lczerner@redhat.com>
Date:   Tue Dec 3 16:24:44 2013 +0100

    libblkid: Identify extN file system properly


  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
