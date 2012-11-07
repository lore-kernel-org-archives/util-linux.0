Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241Ab2KGMRu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Nov 2012 07:17:50 -0500
Date: Wed, 7 Nov 2012 13:17:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: bug: blkid doesn't notice when fs labels change to blank
Message-ID: <20121107121747.GB4383@x2.net.home>
References: <CAMU1PDjWg3AG+V86MmDUC7X-+_DbHhxda_fMSqL9P-do4wC6uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMU1PDjWg3AG+V86MmDUC7X-+_DbHhxda_fMSqL9P-do4wC6uA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 06, 2012 at 10:58:46AM +0100, Mike Fleetwood wrote:
> When the label of a file system is changed from something to blank,
> blkid doesn't recognise that change.
> 
> Test case:
> 
> # mkfs.ext4 -L test_label /dev/sda15
> # blkid /dev/sda15
> /dev/sda15: LABEL="test_label"
> UUID="81d5f9cf-01eb-4861-b284-ea4fa4e92a3f" TYPE="ext4"
> # tune2fs -L '' /dev/sda15
> # tune2fs -l /dev/sda15 | grep 'Filesystem volume name'
> Filesystem volume name:   <none>
> # blkid /dev/sda15
> /dev/sda15: LABEL="test_label"
> UUID="81d5f9cf-01eb-4861-b284-ea4fa4e92a3f" TYPE="ext4
> 
> This seems true regardless of the file system type used.

util-linux version?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
