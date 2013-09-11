Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912Ab3IKPwE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Sep 2013 11:52:04 -0400
Date: Wed, 11 Sep 2013 17:51:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Gabriel de Perthuis <g2p.code@gmail.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: bcache-tools package for Fedora / status probe-bcache
Message-ID: <20130911155155.GA1053@x2.net.home>
References: <521A55D4.20908@rolffokkens.nl>
 <52282A87.4000801@rolffokkens.nl>
 <52285A03.7080802@gmail.com>
 <FEBD3400-93F1-4286-8BE8-45D5413C2EA2@rolffokkens.nl>
 <52286299.7000708@gmail.com>
 <20130909132653.GA8061@x2.net.home>
 <522DE939.5090009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <522DE939.5090009@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 09, 2013 at 05:28:57PM +0200, Gabriel de Perthuis wrote:
> It's correct insofar as current consumers expect it, and it's better
> for error reporting.  The patches took care of my other objections,
> so you can keep the crc check and go with what's on
> https://github.com/g2p/util-linux/commits
> (the csum patches I sent + Rolf's patch + a patch that depends on both).

Merged with some changes

 - not added blkid_probe_is_badcsum() the info about bad csum is
   exported by SBBADCSUM=1 variable, you have to use for example:

       if (blkid_probe_has_value(pr, "SBBADCSUM"))....

 - the usage type is BLKID_USAGE_OTHER rather than "raid" (we have some
   special exceptions and tests for raids that are unnecessary for
   bcache)

I have also added the test images from Rolf to util-linux test suite.

 $ blkid -o udev -p  tests/output/blkid/images-fs/bcache-C.img 
 ID_FS_UUID=7a343627-ac87-4bf0-b76f-46067cbc9b8c
 ID_FS_UUID_ENC=7a343627-ac87-4bf0-b76f-46067cbc9b8c
 ID_FS_TYPE=bcache
 ID_FS_USAGE=other

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
