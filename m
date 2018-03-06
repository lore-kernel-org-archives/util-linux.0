Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:44249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753878AbeCFXpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 18:45:44 -0500
Received: from tenfore.lan ([92.195.17.205]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ7sF-1eo9cD23ff-005Fq3 for
 <util-linux@vger.kernel.org>; Wed, 07 Mar 2018 00:45:42 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: don't lock fd 1 (stdout)
Date: Wed, 7 Mar 2018 00:45:41 +0100
References: <20180306233807.10756-1-sweet_f_a@gmx.de>
In-Reply-To: <20180306233807.10756-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201803070045.41872.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 March 2018, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> On debian-kfreebsd we've locked stdout which messed up our test logs.
> Using /proc/*/fd/ is not portable. Even ts_init's test for
> "/proc/self/fd" does not help because /proc/*/fd behaves strange
> here:
>
>   $ ls -l  /proc/$$/fd
>   lr--r--r-- 1 rudi user 0 Mar  6 23:11 /proc/2194/fd -> unknown
>   $ file /proc/$$/fd
>   /proc/2194/fd: broken symbolic link to `unknown'
>   ## wtf?
>   $ test -d /proc/$$/fd; echo $?
>   0
>   $ ls -l  /proc/$$/fd/
>   ls: cannot access /proc/2194/fd/: No such file or directory
>   ## but
>   $ ls -l  /proc/self/fd/
>   total 0
>   cr-xr-xr-x 1 root root 0, 3 Mar  6 19:39 0
>   cr-xr-xr-x 1 root root 0, 4 Mar  6 19:39 1
>   cr-xr-xr-x 1 root root 0, 5 Mar  6 19:39 2
>   cr-xr-xr-x 1 root root 0, 6 Mar  6 19:39 3
>
> After this patch we are still using /proc/*/fd in ts_get_lock_fd().
> This should be removed too I guess.
>
> This is how this patch changes the test output:
>
> --- /tmp/a      2018-03-06 22:31:15.000000000 +0000
> +++ /tmp/b      2018-03-06 22:30:34.000000000 +0000
> @@ -178,7 +178,7 @@
>          blkid: partitions probing: [06] sgi                  ... OK
>          blkid: partitions probing: [07] sun                  ... OK
>          blkid: partitions probing                            ... OK
> (all 7 sub-tests PASSED) -ls: cannot access /proc/66215/fd/: No such
> file or directory +        blkid: mbr-wholedisk                      
>           ... SKIPPED (missing scsi_debug module (dry-run)) blkid: MD
> raid0 (whole-disks)                        ... SKIPPED (losetup not
> found) blkid: MD raid1 (last partition)                     ...
> SKIPPED (missing in PATH: mdadm) blkid: MD raid1 (whole-disks)       
>                 ... SKIPPED (losetup not found) @@ -343,11 +343,11 @@
>          dmesg: facilities                                    ...
> SKIPPED (test_dmesg not found) dmesg: indentation                    
>               ... SKIPPED (test_dmesg not found) eject: umount       
>                                 ... SKIPPED (eject not found) -ls:
> cannot access /proc/69561/fd/: No such file or directory -ls: cannot
> access /proc/69609/fd/: No such file or directory +        fdisk:
> align 512/4K                                  ... SKIPPED (missing
> scsi_debug module (dry-run)) +        fdisk: align 512/4K
> +alignment_offset                ... SKIPPED (missing scsi_debug
> module (dry-run)) fdisk: align 512/4K +MD                            
>  ... SKIPPED (missing in PATH: mdadm) fdisk: align 512/512           
>                      ... SKIPPED (losetup not found) -ls: cannot
> access /proc/69727/fd/: No such file or directory +        fdisk:
> align 512/512 +topology                       ... SKIPPED (missing
> scsi_debug module (dry-run)) fdisk: nested BSD                       
>             ... OK fdisk: GPT                                        
>   ... OK fdisk: gpt-resize                                    ...
> SKIPPED (losetup not found) @@ -557,8 +557,8 @@
>       libmount: tab files-py: [10] find-target3               ... OK
>       libmount: tab files-py: [11] find-pair                  ... OK
>       libmount: tab files-py                                  ... OK
> (all 11 sub-tests PASSED) -ls: cannot access /proc/75670/fd/: No such
> file or directory -ls: cannot access /proc/75718/fd/: No such file or
> directory +     libmount: tags                                       
>   ... SKIPPED (missing scsi_debug module (dry-run)) +     libmount:
> tags-py                                       ... SKIPPED (missing
> scsi_debug module (dry-run)) libmount: tab update: [01] utab-mount   
>                ... OK libmount: tab update: [02] utab-move           
>         ... OK libmount: tab update: [03] utab-remount               
>  ... OK @@ -709,12 +709,12 @@
>         script: options                                       ...
> SKIPPED (test_script not found) script: race conditions              
>                 ... SKIPPED (script not found) script: replay        
>                                ... SKIPPED (script not found) -ls:
> cannot access /proc/79755/fd/: No such file or directory -ls: cannot
> access /proc/79803/fd/: No such file or directory -ls: cannot access
> /proc/79851/fd/: No such file or directory -ls: cannot access
> /proc/79899/fd/: No such file or directory -ls: cannot access
> /proc/79947/fd/: No such file or directory -ls: cannot access
> /proc/79995/fd/: No such file or directory +       sfdisk: MBR       
>                                    ... SKIPPED (missing scsi_debug
> module (dry-run)) +       sfdisk: GPT                                
>           ... SKIPPED (missing scsi_debug module (dry-run)) +      
> sfdisk: movedata                                      ... SKIPPED
> (missing scsi_debug module (dry-run)) +       sfdisk: resize         
>                               ... SKIPPED (missing scsi_debug module
> (dry-run)) +       sfdisk: GPT                                       
>    ... SKIPPED (missing scsi_debug module (dry-run)) +       sfdisk:
> wipe                                          ... SKIPPED (missing
> scsi_debug module (dry-run)) sha1: sha1                              
>            ... OK swapon: by devname                                 
>   ... SKIPPED (swapon not found) swapon: fix page size               
>                  ... SKIPPED (swapon not found) @@ -739,7 +739,7 @@
>           uuid: uuidgen                                       ... OK
>           uuid: uuidparse                                     ... OK
>           uuid: uuid_parser                                   ... OK
> -ls: cannot access /proc/81134/fd/: No such file or directory
> +       wipefs: wipefs                                        ...
> SKIPPED (missing scsi_debug module (dry-run))
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/expected/rename/basic |  1 -
>  tests/functions.sh          | 22 ++++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tests/expected/rename/basic
> b/tests/expected/rename/basic index 8a7a1d804..2c549a270 100644
> --- a/tests/expected/rename/basic
> +++ b/tests/expected/rename/basic
> @@ -1,4 +1,3 @@
>  `rename_basic.1' -> `rename_test.1'
>  `rename_basic.2' -> `rename_test.2'
>  `rename_basic.3' -> `rename_test.3'
> -what is rename_basic.? doing here?
> diff --git a/tests/functions.sh b/tests/functions.sh
> index d1c97e0b6..8cc148fb8 100644
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -226,6 +226,8 @@ function ts_init_env {
>  	local mydir=$(ts_abspath ${0%/*})
>  	local tmp
>
> +	shopt -s nullglob
> +
>  	LANG="POSIX"
>  	LANGUAGE="POSIX"
>  	LC_ALL="POSIX"
> @@ -697,7 +699,7 @@ function ts_get_lock_fd {
>          local proc=$1
>          local lockfile=$2
>
> -        for fd in $(ls /proc/$proc/fd); do
> +        for fd in /proc/$proc/fd/*; do
>                  file=$(readlink "/proc/$proc/fd/$fd")
>                  if [ x"$file" = x"$lockfile" ]; then
>                          echo "$fd"
> @@ -707,6 +709,22 @@ function ts_get_lock_fd {
>          return 1
>  }
>
> +#
> https://stackoverflow.com/questions/41603787/how-to-find-next-availab
>le-file-descriptor-in-bash +function ts_find_free_fd()
> +{
> +	local rco
> +	local rci
> +	for fd in {0..200}; do

Maybe we should use {3..200} to safe a few loops in 99.9% of all runs. 

> +		rco="$(true 2>/dev/null >&${fd}; echo $?)"
> +		rci="$(true 2>/dev/null <&${fd}; echo $?)"
> +		if [[ "${rco}${rci}" = "11" ]]; then
> +			echo "$fd"
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
>  function ts_lock {
>  	local resource="$1"
>  	local lockfile="${TS_LOCKDIR}/${resource}.lock"
> @@ -723,7 +741,7 @@ function ts_lock {
>  		return 0
>  	fi
>
> -	fd=$(( $(ls /proc/$$/fd/ | sort | tail -1) + 1))
> +	fd=$(ts_find_free_fd) || ts_skip "failed to find lock fd"
>
>  	eval "exec $fd>$lockfile"
>  	flock --exclusive --timeout 30 $fd || ts_skip "failed to lock
> $resource"
