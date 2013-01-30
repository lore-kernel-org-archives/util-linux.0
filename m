Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab3A3Ov7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Jan 2013 09:51:59 -0500
Date: Wed, 30 Jan 2013 15:51:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [docbug] the example for 'whereis -u' lacks an '-ms'?
Message-ID: <20130130145154.GE3741@x2.net.home>
References: <1358962957.12932.140661181409881.123EF29C@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358962957.12932.140661181409881.123EF29C@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 23, 2013 at 06:42:37PM +0100, Benno Schulenberg wrote:
> $ whereis -V
> whereis from util-linux 2.20.1
> 
> But current git still behaves the same.

 whereis(1) needs our love...

 Note that there is a patch to improve whereis(1)
    http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/6474
 from Ondrej, but I haven't time to test & cleanup yet. Volunteers? :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
