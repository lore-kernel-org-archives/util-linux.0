Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30965 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab2GXLWV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:22:21 -0400
Date: Tue, 24 Jul 2012 13:22:17 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>, Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 02/10] fdisk: API: add to label operations to context
Message-ID: <20120724112217.GB7057@x2.net.home>
References: <1342976701.2863.12.camel@offbook>
 <20120724094131.GB2086@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724094131.GB2086@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 24, 2012 at 11:41:31AM +0200, Petr Uzel wrote:
> On Sun, Jul 22, 2012 at 07:05:01PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > The context structure is the fdisk API's main data type as it keeps all data together. Add the
> > label structure to it, so that the pt-specific operations can be called from the context.

 Applied with changes, thanks.

> > The internal probing function is updated so that if a label is not probed, for example when a
> > disk is not formated, it will default to use either sun or dos label operations. This avoids

 This is not so simple. You have to apply geometry and another
 settings (sector size, ...) from user *before* you create a new disk
 label.  (See the original code, get_boot() and get_geometry()
 functions.)

 It means that we should not create any default disklabel in
 fdisk_new_context_from_filename(). I think it will be better to make
 the API less complex and split this task into two steps:

    cxt = fdisk_new_context_from_filename(devname, 0);

    /* --- here apply your setting to the new context -- */

    if (!fdisk_dev_has_disklabel(cxt))
        fdisk_create_disklabel(cxt, NULL);      /* NULL means default */


 It should be our common rule that the API is well fragmented to small
 usable functions.

 Maybe one day we will create

     fdisk_new_context()
     fdisk_context_assign_device()

 because the current fdisk_new_context_from_filename() is already too
 complex for some scenarios -- for example if you want to add some
 callbacks to the context.  We will see ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
