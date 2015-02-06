Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbbBFJhb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Feb 2015 04:37:31 -0500
Date: Fri, 6 Feb 2015 10:37:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
Message-ID: <20150206093717.GB8546@x2.net.home>
References: <20150204115353.GC1238@ws.net.home>
 <1423172910.109711.223698217.4EC40FCF@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1423172910.109711.223698217.4EC40FCF@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 05, 2015 at 10:48:30PM +0100, Benno Schulenberg wrote:
> 
> On Wed, Feb 4, 2015, at 12:53, Karel Zak wrote:
> > 
> > The util-linux release v2.26-rc2 is available at
> > 
> >   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26
> 
> It compiles without error, but shows these warnings along the way:
> 
> libfdisk/src/dos.c: In function 'add_partition':
> libfdisk/src/dos.c:1204: warning: format '%ju' expects type 'uintmax_t', but argument 4 has type 'long unsigned int'

 fixed

> sys-utils/ipcs.c: In function ‘do_shm’:
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
> sys-utils/ipcs.c:223: note: initialized from here
> 
> sys-utils/ipcutils.c: In function ‘ipc_shm_get_limits’:
> sys-utils/ipcutils.c:92: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:91: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:90: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
> sys-utils/ipcutils.c:89: note: initialized from here

 This does not happen with gcc version 4.9.2. If I good remember some
 old gcc versions are too strict on strict aliasing rules and it's
 almost impossible to cast non-allocated memory...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
