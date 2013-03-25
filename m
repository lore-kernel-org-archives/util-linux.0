Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756758Ab3CYITD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Mar 2013 04:19:03 -0400
Date: Mon, 25 Mar 2013 09:18:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount crashes when trying to umount a non-mountpoint
Message-ID: <20130325081859.GA9478@x2.net.home>
References: <kiijva$3gc$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <kiijva$3gc$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 22, 2013 at 11:54:52PM +0200, Mantas Mikulėnas wrote:
> If I run `umount /foo` where /foo is an existing directory, but not a
> mountpoint, `umount` (v2.23-rc1) crashes in mnt_copy_fs() instead of
> printing the usual "not mounted" message:

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
