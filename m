Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbcFNIax (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2016 04:30:53 -0400
Date: Tue, 14 Jun 2016 10:30:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fstab format
Message-ID: <20160614083051.2rm5bdksffs6hiei@ws.net.home>
References: <575F3F4C.9020103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575F3F4C.9020103@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 13, 2016 at 06:18:36PM -0500, Bruce Dubbs wrote:
> Does the fstab file support line continuation with a backslash-newline?

No.

> There is no indication in the fstab man page one way or another.  In the
> case of some entries that use long device IDs like PARTUUID or several
> options, it would be nice to be able to control the format for easier
> reading.

Yes, but fstab is de-facto standard file parsed on many many places.
We cannot change/extend the file format.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
