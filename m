Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30056 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965029Ab1GMImq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 04:42:46 -0400
Date: Wed, 13 Jul 2011 10:42:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Brad Goodman <brad@bradgoodman.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Error in man page for fstab
Message-ID: <20110713084243.GB3486@nb.net.home>
References: <CAAN0OpipdTBHfJGJG0s-YQQ0EbmrLzCkh6PWfHvVAdz78mFE6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAN0OpipdTBHfJGJG0s-YQQ0EbmrLzCkh6PWfHvVAdz78mFE6w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 12, 2011 at 12:21:58PM -0400, Brad Goodman wrote:
> The fstab man page contains the following text:
> 
> >> The third field, (fs_vfstype) ... An entry "none" is  useful  for bind or move mounts
> 
> "none" is interpreted as an actual vfstype, which does not have the
> intended consequences.

 The bind mounts are completely independent on FS type. The type does
 not make sense here. The recent version of the mount(8) always
 overwrites the FS type to "none" for all MS_BIND, MS_MOVE and
 MS_PROPAGATION operations.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
