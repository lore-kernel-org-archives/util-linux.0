Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:53299 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753793Ab1HGQFW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Aug 2011 12:05:22 -0400
Subject: Re: [PATCH] Add a new documentation directory and move the
 README.devel file there.
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <1312677229.3408.2.camel@offbook>
References: <1312677229.3408.2.camel@offbook>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 07 Aug 2011 12:05:13 -0400
Message-ID: <1312733113.3269.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

ah, never mind, I didn't see Sami's patch.

On Sat, 2011-08-06 at 20:33 -0400, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  Documentation/README.devel |  121 ++++++++++++++++++++++++++++++++++++++++++++
>  README.devel               |  121 --------------------------------------------
>  2 files changed, 121 insertions(+), 121 deletions(-)
>  create mode 100644 Documentation/README.devel
>  delete mode 100644 README.devel
> 
> diff --git a/Documentation/README.devel b/Documentation/README.devel
> new file mode 100644
> index 0000000..d76baaf
> --- /dev/null
> +++ b/Documentation/README.devel
> @@ -0,0 +1,121 @@
> +
> + Notes for util-linux developers
> + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +AUTOTOOLS:
> +
> +     * "./autogen.sh" generates all files needed to compile and install the code
> +       (run it after checkout from git)
> +
> +     * "make distclean" removes all unnecessary files, but the code can still be
> +       recompiled with "./configure; make"
> +
> +     * "make dist-gzip" (or -bzip2) creates a tarball that can be configured and
> +       compiled without running "./autogen.sh"
> +
> +
> +PATCHES:
> +
> +     * send your patches to the mailing list or to the upstream maintainer
> +       (see the AUTHORS and README files)
> +
> +     * diff -u
> +
> +     * don't include generated (autotools) stuff to your patches
> +       (hint: use git-clean [-X])
> +
> +     * patches are delivered via email only.  Downloading them from internet
> +       servers is a pain.
> +
> +     * one patch per email, with the changelog in the body of the email.
> +
> +     * many small patches are favoured over one big. Break down is done on
> +       basis of logical functionality; for example #endif mark ups, compiler
> +       warning and exit codes fixes all should be individual small patches.
> +
> +     * Subject: [PATCH] subsystem: description
> +
> +     * if someone else wrote the patch, they should be credited (and blamed)
> +       for it. To communicate this, add a line:
> +
> +          From: John Doe <jdoe@wherever.com>
> +
> +     * add a Signed-off-by line (hint: use "git commit -s")
> +
> +       The sign-off is a simple line at the end of the explanation for the
> +       patch, which certifies that you wrote it or otherwise have the right to
> +       pass it on as a open-source patch.  The rules are pretty simple: if you
> +       can certify the below:
> +
> +           By making a contribution to this project, I certify that:
> +
> +           (a) The contribution was created in whole or in part by me and I
> +               have the right to submit it under the open source license
> +               indicated in the file; or
> +
> +           (b) The contribution is based upon previous work that, to the best
> +               of my knowledge, is covered under an appropriate open source
> +               license and I have the right under that license to submit that
> +               work with modifications, whether created in whole or in part
> +               by me, under the same open source license (unless I am
> +               permitted to submit under a different license), as indicated
> +               in the file; or
> +
> +           (c) The contribution was provided directly to me by some other
> +               person who certified (a), (b) or (c) and I have not modified it.
> +
> +           (d) I understand and agree that this project and the contribution
> +               are public and that a record of the contribution (including all
> +               personal information I submit with it, including my sign-off) is
> +               maintained indefinitely and may be redistributed consistent with
> +               this project or the open source license(s) involved.
> +
> +       then you just add a line saying
> +
> +               Signed-off-by: Random J Developer <random@developer.example.org>
> +
> +       using your real name (sorry, no pseudonyms or anonymous contributions.)
> +
> +
> +     * for more details see:
> +
> +       The perfect patch
> +                http://userweb.kernel.org/~akpm/stuff/tpp.txt
> +
> +CODING STYLE:
> +
> +     * the preferred coding style is based on the linux kernel Documentation/CodingStyle.
> +       For more details see:
> +
> +       http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/CodingStyle
> +
> +
> +SCM (source code management):
> +
> +     git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
> +
> +
> +    * maintenance (stable) branch
> +        - created for every <major>.<minor> release
> +        - branch name: stable/v<major>.<minor>
> +
> +    * bugfix branch
> +        - created for <major>.<minor>.<maint> release for critical/security bugs only
> +        - this branch is optional
> +        - branch name: stable/v<major>.<minor>.<maint>
> +
> +    * master branch
> +        - the status of this branch is: "it works for me". It means useful
> +          but not well tested patches.
> +        - it's source for occasional snapshots
> +        - for long-term development or invasive changes should be an active
> +          development forked into a separate branch (topic branches) from the
> +          tip of "master".
> +
> +    * A new tag object is created for:
> +        - every release, tag name: v<version>
> +
> +
> +    * KNOWN BUGS:
> +        - tag v2.13.1 is typo. Please, ignore this tag.
> +
> diff --git a/README.devel b/README.devel
> deleted file mode 100644
> index d76baaf..0000000
> --- a/README.devel
> +++ /dev/null
> @@ -1,121 +0,0 @@
> -
> - Notes for util-linux developers
> - ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -
> -AUTOTOOLS:
> -
> -     * "./autogen.sh" generates all files needed to compile and install the code
> -       (run it after checkout from git)
> -
> -     * "make distclean" removes all unnecessary files, but the code can still be
> -       recompiled with "./configure; make"
> -
> -     * "make dist-gzip" (or -bzip2) creates a tarball that can be configured and
> -       compiled without running "./autogen.sh"
> -
> -
> -PATCHES:
> -
> -     * send your patches to the mailing list or to the upstream maintainer
> -       (see the AUTHORS and README files)
> -
> -     * diff -u
> -
> -     * don't include generated (autotools) stuff to your patches
> -       (hint: use git-clean [-X])
> -
> -     * patches are delivered via email only.  Downloading them from internet
> -       servers is a pain.
> -
> -     * one patch per email, with the changelog in the body of the email.
> -
> -     * many small patches are favoured over one big. Break down is done on
> -       basis of logical functionality; for example #endif mark ups, compiler
> -       warning and exit codes fixes all should be individual small patches.
> -
> -     * Subject: [PATCH] subsystem: description
> -
> -     * if someone else wrote the patch, they should be credited (and blamed)
> -       for it. To communicate this, add a line:
> -
> -          From: John Doe <jdoe@wherever.com>
> -
> -     * add a Signed-off-by line (hint: use "git commit -s")
> -
> -       The sign-off is a simple line at the end of the explanation for the
> -       patch, which certifies that you wrote it or otherwise have the right to
> -       pass it on as a open-source patch.  The rules are pretty simple: if you
> -       can certify the below:
> -
> -           By making a contribution to this project, I certify that:
> -
> -           (a) The contribution was created in whole or in part by me and I
> -               have the right to submit it under the open source license
> -               indicated in the file; or
> -
> -           (b) The contribution is based upon previous work that, to the best
> -               of my knowledge, is covered under an appropriate open source
> -               license and I have the right under that license to submit that
> -               work with modifications, whether created in whole or in part
> -               by me, under the same open source license (unless I am
> -               permitted to submit under a different license), as indicated
> -               in the file; or
> -
> -           (c) The contribution was provided directly to me by some other
> -               person who certified (a), (b) or (c) and I have not modified it.
> -
> -           (d) I understand and agree that this project and the contribution
> -               are public and that a record of the contribution (including all
> -               personal information I submit with it, including my sign-off) is
> -               maintained indefinitely and may be redistributed consistent with
> -               this project or the open source license(s) involved.
> -
> -       then you just add a line saying
> -
> -               Signed-off-by: Random J Developer <random@developer.example.org>
> -
> -       using your real name (sorry, no pseudonyms or anonymous contributions.)
> -
> -
> -     * for more details see:
> -
> -       The perfect patch
> -                http://userweb.kernel.org/~akpm/stuff/tpp.txt
> -
> -CODING STYLE:
> -
> -     * the preferred coding style is based on the linux kernel Documentation/CodingStyle.
> -       For more details see:
> -
> -       http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/CodingStyle
> -
> -
> -SCM (source code management):
> -
> -     git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
> -
> -
> -    * maintenance (stable) branch
> -        - created for every <major>.<minor> release
> -        - branch name: stable/v<major>.<minor>
> -
> -    * bugfix branch
> -        - created for <major>.<minor>.<maint> release for critical/security bugs only
> -        - this branch is optional
> -        - branch name: stable/v<major>.<minor>.<maint>
> -
> -    * master branch
> -        - the status of this branch is: "it works for me". It means useful
> -          but not well tested patches.
> -        - it's source for occasional snapshots
> -        - for long-term development or invasive changes should be an active
> -          development forked into a separate branch (topic branches) from the
> -          tip of "master".
> -
> -    * A new tag object is created for:
> -        - every release, tag name: v<version>
> -
> -
> -    * KNOWN BUGS:
> -        - tag v2.13.1 is typo. Please, ignore this tag.
> -


