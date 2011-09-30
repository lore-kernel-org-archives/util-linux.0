Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757621Ab1I3JfM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Sep 2011 05:35:12 -0400
Date: Fri, 30 Sep 2011 11:35:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] losetup: rewrite
Message-ID: <20110930093507.GK19994@nb.net.home>
References: <1317066589.2896.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317066589.2896.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 26, 2011 at 04:49:49PM -0300, Davidlohr Bueso wrote:
> Instead of a complete rewrite from scratch, like it was initially
> planned, its better to do it incrementally, which makes it easier to
> regression test.

 I agree, do it incrementally is better for review. Anyway for merge
 into master branch we need all changes.

 Suggestion:

  1. use directly lib/loopdev.c stuff in mount.c and umount.c 

     -- I did this yesterday. So you don't have to fight with 
        unreadable spaghetti in mount.c (check_loop() is hell)...


  2. remove obsolete things (e.g. #ifdef !MAIN)

  3. remove code around old non-64bit ioctls

  4. remove lomount.h and loop.h (include/loopdev.h has to be enough)

  5. move mount/lomount.c to sys-utils/losetup.c

  6. use lib/loopdev.c stuff in sys-utils/losetup.c

     - it should be possible to initialize one struct loopdev_cxt in main() and
       use it in all operations

     - rather than many variables (capacity, find, all, showdev,
       assoc, delete, ...) use any enum for requested operation and
       switch(command) as a core of the main().



    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
