Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44089 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab1HHLqU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2011 07:46:20 -0400
Date: Mon, 8 Aug 2011 13:46:17 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] documentation directory
Message-ID: <20110808114617.GL2204@nb.net.home>
References: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 06, 2011 at 07:57:53PM +0200, Sami Kerola wrote:
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit docs-dir
> 
> discussion, and few rejects, before the Documentation/ is done to
> upstream. For instance you might disagree with contents of
> 00-about-docs.txt, and perhaps example.files/ should be deleted.

 The 'Warning about content' in 00-about-docs.txt is too crazy :-)
 Let's:
 
  - cleanup the files
  - remove obsolete information
  - move valid information to the man pages
  - add info about authors to the AUTHORS file
 
 I have updated the example.files/ in the master branch.

>  README.devel => Documentation/README.devel         |    0

 see below

>  .../ReleaseNotes}/v2.13-ReleaseNotes               |    0

 What about to rename the directory to releases/ ? The NEWS file should
 be updated too.

>  README.licensing => Documentation/licensing.txt    |    0

 It would be nice to keep this file in the top-level directory.

>  tests/README => Documentation/tests.txt            |    0

 howto-tests.txt

>  Documentation/usage-howto.txt                      |   73 ++++++++++++++++++++

 howto-usage-function.txt

   and s/output/display/ in the file

 we also need howto-man-page.txt :-)


 I think we can split the README file:

    README  (basic info about project)

    Documentation/howto-compilation.txt 

 In the howto-compilation.txt file should be also a note about
 autogen.sh, static linking, klib and uClib and maybe some preferred
 compiler options, I use:
 
   -Wmissing-parameter-type -Wsign-compare -Wtype-limits -Wuninitialized \
   -Wunused-parameter -Wunused-but-set-parameter -fno-common

 We can also split README.devel to:

    Documentation/howto-compilation.txt (add extra section for
    developers (or SCM users) about about autotools).

    Documentation/howto-contribute.txt with info about "ideal
    patches", coding style.

    Documentation/source-code-management.txt


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
