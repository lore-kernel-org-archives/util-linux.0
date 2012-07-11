Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50454 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932467Ab2GKQES (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Jul 2012 12:04:18 -0400
Date: Wed, 11 Jul 2012 18:04:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: autogen.sh failing because of missing misc-utils/uuidd* files
Message-ID: <20120711160413.GJ5281@x2.net.home>
References: <4FFD82D8.6090301@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FFD82D8.6090301@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 11, 2012 at 03:42:48PM +0200, Bernhard Voelker wrote:
> configure.ac:9: installing `config/missing'
> configure.ac:1320: required file `misc-utils/uuidd.8.in' not found
> configure.ac:1320: required file `misc-utils/uuidd.rc.in' not found
> configure.ac:1320: required file `misc-utils/uuidd.socket.in' not found
> 
> These files somed to be deleted ...
> What's wrong?

Fixed. I forgot 'git add' yesterday. Sorry.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
