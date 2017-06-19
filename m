Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdFSSO0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 14:14:26 -0400
Subject: Re: [PATCH] uuidparse: add new command
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
References: <20170618172536.21544-1-kerolasa@iki.fi>
 <201706191122.48481.sweet_f_a@gmx.de>
 <20170619092813.evirrk3zy6omv6xi@ws.net.home>
 <201706191155.23149.sweet_f_a@gmx.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <072f3a28-9fd9-dc68-adcf-d35081437d0c@gmx.com>
Date: Mon, 19 Jun 2017 14:14:02 -0400
MIME-Version: 1.0
In-Reply-To: <201706191155.23149.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 06/19/2017 05:55 AM, Ruediger Meier wrote:
> On Monday 19 June 2017, Karel Zak wrote:
>> On Mon, Jun 19, 2017 at 11:22:48AM +0200, Ruediger Meier wrote:

 -->8

On a related note: could we add USAGE_*_NN with no trailing newline for
use with puts() on new/converted commands? For example:

#define USAGE_HEADER        _("\nUsage:\n")
#define USAGE_HEADER_NN     _("\nUsage:")

>>> BTW currently I'm going through the whole project to correct all
>>> commands where we spam the whole usage in case of errors.

I had that on my todo list, but I'll gladly let you handle it ;)
Here are a few more to add to your list:

grep -ErnI 'usage\(stderr' | sort

disk-utils/addpart.c:53:                usage(stderr);
disk-utils/blockdev.c:229:              usage(stderr);
disk-utils/blockdev.c:271:              usage(stderr);
disk-utils/blockdev.c:318:              usage(stderr);
disk-utils/blockdev.c:335:              usage(stderr);
disk-utils/delpart.c:53:                usage(stderr);
disk-utils/fdformat.c:219:              usage(stderr);
disk-utils/fdisk.c:1003:                usage(stderr);
disk-utils/fdisk.c:855:                 usage(stderr);
disk-utils/fdisk.c:884:                 usage(stderr);
disk-utils/fdisk.c:932:                 usage(stderr);
disk-utils/fdisk.c:989:                 usage(stderr);
disk-utils/fsck.c:1539:                 usage(stderr);
disk-utils/fsck.c:1545:                 usage(stderr);
disk-utils/fsck.minix.c:1339:           usage(stderr);
disk-utils/isosize.c:190:               usage(stderr);
disk-utils/mkfs.bfs.c:133:              usage(stderr);
disk-utils/mkfs.bfs.c:180:              usage(stderr);
disk-utils/mkfs.bfs.c:195:              usage(stderr);
disk-utils/mkfs.c:118:                  usage(stderr);
disk-utils/mkfs.minix.c:809:            usage(stderr);
disk-utils/mkswap.c:415:                usage(stderr);
disk-utils/mkswap.c:431:                usage(stderr);
disk-utils/partx.c:968:                 usage(stderr);
disk-utils/resizepart.c:95:             usage(stderr);
disk-utils/swaplabel.c:176:             usage(stderr);
libsmartcols/samples/fromfile.c:303:    usage(stderr);
libsmartcols/samples/tree.c:220:        usage(stderr);
login-utils/chfn.c:193:                 usage(stderr);
login-utils/chsh.c:239:                 usage(stderr);
login-utils/chsh.c:249:                 usage(stderr);
login-utils/sulogin.c:878:              usage(stderr);
misc-utils/cal.c:473:                   usage(stderr);
misc-utils/look.c:146:                  usage(stderr);
misc-utils/rename.c:201:                usage(stderr);
misc-utils/test_uuidd.c:291:            usage(stderr);
misc-utils/whereis.c:506:               usage(stderr);
misc-utils/whereis.c:551:               usage(stderr);
misc-utils/whereis.c:560:               usage(stderr);
misc-utils/whereis.c:569:               usage(stderr);
misc-utils/whereis.c:609:               usage(stderr);
misc-utils/wipefs.c:556:                usage(stderr);
schedutils/ionice.c:262:                usage(stderr);
schedutils/taskset.c:188:               usage(stderr);
sys-utils/blkdiscard.c:177:             usage(stderr);
sys-utils/chcpu.c:341:                  usage(stderr);
sys-utils/chmem.c:317:                  chmem_usage(stderr);
sys-utils/dmesg.c:1390:                 usage(stderr);
sys-utils/fsfreeze.c:112:               usage(stderr);
sys-utils/fstrim.c:335:                 usage(stderr);
sys-utils/ipcmk.c:135:                  usage(stderr);
sys-utils/ipcrm.c:161:                  usage(stderr);
sys-utils/losetup.c:863:                usage(stderr);
sys-utils/lscpu.c:2178:                 usage(stderr);
sys-utils/lsipc.c:1231:                 usage(stderr);
sys-utils/lsmem.c:498:                  lsmem_usage(stderr);
sys-utils/mount.c:694:                  usage(stderr);
sys-utils/mount.c:705:                  usage(stderr);
sys-utils/mount.c:772:                  usage(stderr);
sys-utils/mountpoint.c:181:             usage(stderr);
sys-utils/pivot_root.c:72:              usage(stderr);
sys-utils/renice.c:146:                 usage(stderr);
sys-utils/renice.c:150:                 usage(stderr);
sys-utils/rtcwake.c:501:                usage(stderr);
sys-utils/setsid.c:87:                  usage(stderr);
sys-utils/swapoff.c:231:                usage(stderr);
sys-utils/swapon.c:984:                 usage(stderr);
sys-utils/switch_root.c:241:            usage(stderr);
sys-utils/switch_root.c:248:            usage(stderr);
sys-utils/tunelp.c:148:                 print_usage(stderr);
sys-utils/tunelp.c:246:                 print_usage(stderr);
sys-utils/tunelp.c:262:                 print_usage(stderr);
sys-utils/umount.c:524:                 usage(stderr);
term-utils/agetty.c:790:                usage(stderr);
term-utils/agetty.c:798:                usage(stderr);
term-utils/agetty.c:807:                usage(stderr);
term-utils/mesg.c:162:                  usage(stderr);
term-utils/setterm.c:1174:              usage(stderr);
term-utils/write.c:322:                 usage(stderr);
tests/helpers/test_sigreceive.c:73:     usage(stderr);
text-utils/col.c:230:                   usage(stderr);
text-utils/more.c:323:                  usage(stderr);
text-utils/more.c:491:                  usage(stderr);
text-utils/pg.c:259:                    usage(stderr);
text-utils/pg.c:265:                    usage(stderr);


>> That's legacy from time we used usage(stderr) for command line
>> parsing errors. Now we use errtryhelp().
> 
> Yes I know, but there are still a few commands where we could 
> correct --help, etc.
> 
> FYI I've made a little script to find candidates to fix, see below. I 
> will send some patches.
> 
> $ ./tools/check_help.sh
> flock: --help, no stdout
> flock: --help, non-empty stderr
> getopt: --help, returns error
> kill: --unknownopt, stderr too short: 1
> mkfs.cramfs: --help, returns error
> mkfs.cramfs: --version, returns error
> whereis: --help, returns error
> whereis: --version, returns error
> whereis: --unknownopt, stderr too long: 18
> agetty: --unknownopt, stderr too long: 45
> blockdev: --unknownopt, stderr too long: 28
> fsck: --help, returns error
> fsck: --version, returns error
> fsck: --unknownopt, non-empty stdout
> fsck: --unknownopt, stderr too long: 18
> login: --help, returns error
> login: --version, returns error
> login: --unknownopt, stderr too long: 4
> lsipc: --unknownopt, stderr too long: 77
> mkfs: --unknownopt, stderr too long: 8
> more: --help, returns error
> more: --version, returns error
> more: --unknownopt, stderr too long: 21
> nologin: --help, returns error
> nologin: --version, returns error
> pg: --unknownopt, stderr too long: 23
> renice: --unknownopt, stderr too long: 18
> rtcwake: --unknownopt, non-empty stdout
> rtcwake: --unknownopt, stderr too long: 21
> sulogin: --unknownopt, stderr too long: 17
> write: --unknownopt, stderr too long: 12
> 
> (There are also some false positives like nologin.)
> 
> cu,
> Rudi
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
