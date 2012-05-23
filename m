Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51407 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2EWJnU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 05:43:20 -0400
Date: Wed, 23 May 2012 11:42:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/6] fdisk: introduce fdisk context
Message-ID: <20120523094250.GA1297@x2.net.home>
References: <1337530296.2677.16.camel@offbook>
 <20120521094054.GA14560@x2.net.home>
 <1337631275.2596.1.camel@offbook>
 <1337632083.2596.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1337632083.2596.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 21, 2012 at 10:28:03PM +0200, Davidlohr Bueso wrote:
> This is the first patch that adds the initial parts of the new fdisk
> internal API. Two functions are created to both init and deinit the
> fdisk context. Only the device's descriptor and path are added as a
> start and these are replaced throughout fdisk.c and label specific
> code.

Applied (and the rest of the patches too), thanks.

> All logic that opens the file does it with
> fdisk_new_context_from_filename(), and this enforces always opening
> the device with rw

I have added 'readonly' option to the fdisk_new_context_from_filename().

It would be better to minimize number of situation where we somewhere
open devices read-write. For example udevd, udisks, ... are pretty
sensitive to write operations (to detect new PT or new filesystem
etc.).

Notes:

1/ What about to rename fdisk_new_context_from_filename() to
   fdisk_new_context()? I guess that the device name is mandatory option.

2/ Please, don't use global 'cxt' if possible. See for example

   get_geometry() -> get_topology()

   disk.c: In function ‘get_topology’:
   fdisk.c:456:18: warning: unused parameter ‘fd’ [-Wunused-parameter]

  there is get_geometry(cxt->fd, ...), but get_topology() ignores the
  parameter 'fd' and the function uses the global cxt->fd. This is
  nasty :-)

  It would be better to rename global 'cxt' to something less generic
  and everywhere in functions use 'cxt' parameter, for example:

     get_geometry(struct fdisk_context *cxt, struct geom *g);


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
