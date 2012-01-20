Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab2ATJeg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Jan 2012 04:34:36 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0K9YZ8C022593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 20 Jan 2012 04:34:35 -0500
Date: Fri, 20 Jan 2012 10:34:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: memory leaks tests (Re: [PATCH] Fix a potential memory leak at
 mnt_table_parse_dir)
Message-ID: <20120120093433.GA13157@x2.net.home>
References: <20120120.130034.1018682633157048125.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120120.130034.1018682633157048125.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 20, 2012 at 01:00:34PM +0900, Masatake YAMATO wrote:
> mnt_table_parse_dir in libmount/src/tab_parse.c calls
> scandir, and then opendir. When the latter one, opendir is failed, 
> buffers allocated in scandir are not released.

 Thanks, I'll apply the patch.

 BTW, it's possible to compile some test binaries by:

    make -C libmount/src tests

 these programs are used in tests/ts/libmount regression tests.

 It would be nice to add valgrind (or so) to the tests and check for
 mem-leaks. (Ideally add some simple infrastructure to tests/functions.sh
 and log valgrind output to "$TS_OUTPUT.mem".)  Volunteer? ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
