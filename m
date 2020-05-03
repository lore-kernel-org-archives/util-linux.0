Return-Path: <SRS0=xpUH=6R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4ADC28CBC
	for <util-linux@archiver.kernel.org>; Sun,  3 May 2020 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD74206E9
	for <util-linux@archiver.kernel.org>; Sun,  3 May 2020 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgECTSn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 3 May 2020 15:18:43 -0400
Received: from luckmann.name ([213.239.213.133]:52049 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729033AbgECTSm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 May 2020 15:18:42 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 May 2020 15:18:37 EDT
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E56022.000000005EAF17E0.00006E77; Sun, 03 May 2020 21:13:36 +0200
Date:   Sun, 3 May 2020 21:13:36 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Errors in man pages of util-linux
Message-ID: <20200503191335.GB27970@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-28279-1588533216-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-28279-1588533216-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear util-linux maintainers.
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including util-linux) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometiems this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the=20
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. If future reports should=20
use another channel, please let me know.

**

Man page: adjtime_config.5
Issue: Superfluous comma after "is"

"The format of the adjtime file is, in ASCII."
--
Man page: adjtime_config.5
Issue: hwckock =E2=86=92 hwclock

"The Hardware Clock is usually not very accurate.  However, much of its "
"inaccuracy is completely predictable - it gains or loses the same amount o=
f "
"time every day.  This is called systematic drift.  The util hwclock keeps "
"the file /etc/adjtime, that keeps some historical information.  For more "
"details see \"B<The Adjust Function>\" and \"B<The Adjtime File>\" section=
s "
"from B<hwckock>(8)  man page."
--
Man page: agetty.8
Issue: agetty =E2=86=92 B<agetty>

"Display the current issue file (or other) on the current terminal and exit=
=2E  "
"Use this option to review the current setting, it is not designed for any "
"other purpose.  Note that output may use some default or incomplete "
"information as proper output depends on terminal and agetty command line."
--
Man page: agetty.8
Issue: I<inittab(5)> =E2=86=92 B<inittab>(5)

"This section shows examples for the process field of an entry in the I</et=
c/"
"inittab> file.  You'll have to prepend appropriate values for the other "
"fields.  See I<inittab(5)> for more details."
--
Man page: agetty.8
Issue: commandline =E2=86=92 command line

"Some programs use \"--\" to indicate that the rest of the command line "
"should not be interpreted as options.  Use this feature if available by "
"passing \"--\" before the username gets passed by \\eu."
--
Man page: agetty.8
Issue: agetty =E2=86=92 B<agetty>

"Since version 2.35 additional locations for issue file and directory are "
"supported. If the default I</etc/issue> does not exist than agetty checks "
"for I</run/issue> and I</run/issue.d>, thereafter for I</usr/lib/issue> an=
d "
"I</usr/lib/issue.d>.  The directory /etc is expected for host specific "
"configuration, /run is expected for generated stuff and /usr/lib for stati=
c "
"distribution maintained configuration."
--
Man page: agetty.8
Issue: If not any configured =E2=86=92 If no configured

"Insert the IPv4 address of the specified network interface (for example: "
"\\e4{eth0}).  If the I<interface> argument is not specified, then select t=
he "
"first fully configured (UP, non-LOCALBACK, RUNNING) interface.  If not any=
 "
"configured interface is found, fall back to the IP address of the machine'=
s "
"hostname."
--
Man page: blkid.8
Issue: Missing markup from "mount"

"This option forces B<blkid> to use udev when used for LABEL or UUID tokens=
 "
"in B<--match-token>. The goal is to provide output consistent with another=
 "
"utils (like mount, etc.)  on systems where the same tag is used for multip=
le "
"devices."
--
Man page: blkzone.8
Issue: Double full stop

"Display the number of zones returned in the report or the range of sectors=
 "
"reset.."
--
Man page: chfn.1
Issue: Missing markup for command name

"The chfn command is part of the util-linux package and is available from "
"https://www.kernel.org/pub/linux/utils/util-linux/."
--
Man page: chsh.1
Issue: Missing markup for command name

"The chsh command is part of the util-linux package and is available from "
"https://www.kernel.org/pub/linux/utils/util-linux/."
--
Man page: col.1
Issue: Missing markup for command name

"The col command is part of the util-linux package and is available from E<=
=2E"
"UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linu=
x "
"Kernel Archive E<.UE .>"
--
Man page: colcrt.1
Issue: invisible =E2=86=92 partially invisible

"Causes all half-lines to be printed, effectively double spacing the output=
=2E  "
"Normally, a minimal space output format is used which will suppress empty "
"lines.  The program never suppresses two consecutive empty lines, however.=
  "
"The B<-2> option is useful for sending output to the line printer when the=
 "
"output contains superscripts and subscripts which would otherwise be "
"invisible."
--
Man page: colcrt.1
Issue: B<'-'> =E2=86=92 B<->

"Should fold underlines onto blanks even with the B<'-'> option so that a "
"true underline character would show."
--
Man page: colrm.1
Issue: Missing markup for command name

"The colrm command is part of the util-linux package and is available from =
E<."
"UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linu=
x "
"Kernel Archive E<.UE .>"
--
Man page: column.1
Issue: Missing markup for command name

"The column command is part of the util-linux package and is available from=
 "
"https://www.kernel.org/pub/linux/utils/util-linux/."
--
Man page: column.1
Issue: Missing markup for command name

"By default, the column command will merge multiple adjacent delimiters int=
o "
"a single delimiter when using the E<.Fl t> option; this option disables th=
at "
"behavior. This option is a Debian GNU/Linux extension."
--
Man page: fdisk.8
Issue: Why is the full stop at the end in bold?

"Specify the sector size of the disk.  Valid values are 512, 1024, 2048, an=
d "
"4096.  (Recent kernels know the sector size.  Use this option only on old "
"kernels or to override the kernel's ideas.)  Since util-linux-2.17, B<fdis=
k> "
"differentiates between logical and physical sector size.  This option "
"changes both sector sizes to I<sectorsize>B<.>"
--
Man page: fdisk.8
Issue: "when create" =E2=86=92 "when creating"

"Don't erase the begin of the first disk sector when create a new disk "
"label.  This feature is supported for GPT and MBR."
--
Man page: fdisk.8
Issue: Missing markup of file (names)

"The I<device> is usually /dev/sda, /dev/sdb or so.  A device name refers t=
o "
"the entire disk.  Old systems without libata (a library used inside the "
"Linux kernel to support ATA host controllers and devices) make a differenc=
e "
"between IDE and SCSI disks.  In such cases the device name will be /dev/hd=
* "
"(IDE) or /dev/sd* (SCSI)."
--
Man page: fdisk.8
Issue: Content: Do need to mark partitions with =C2=BBvolume=C2=AB and =C2=
=BBvolume
                header=C2=AB

"An IRIX/SGI disklabel can describe 16 partitions, the eleventh of which "
"should be an entire `volume' partition, while the ninth should be labeled "
"`volume header'.  The volume header will also cover the partition table, i=
=2E"
"e., it starts at block zero and extends by default over five cylinders.  T=
he "
"remaining space in the volume header may be used by header directory "
"entries.  No partitions may overlap with the volume header.  Also do not "
"change its type or make some filesystem on it, since you will lose the "
"partition table.  Use this type of label only when working with Linux on "
"IRIX/SGI machines or IRIX/SGI disks under Linux."
--
Man page: fdisk.8
Issue: Missing markup of fdisk

"Usually all goes well by default, and there are no problems if Linux is th=
e "
"only system on the disk.  However, if the disk has to be shared with other=
 "
"operating systems, it is often a good idea to let an fdisk from another "
"operating system make at least one partition.  When Linux boots it looks a=
t "
"the partition table, and tries to deduce what (fake) geometry is required "
"for good cooperation with other systems."
--
Man page: fsck.minix.8
Issue: Replace \(en with Unicode U+2013 '-

msgid "/dev/hda[1\\(en63]"

msgid "/dev/hdb[1\\(en63]"

msgid "/dev/sda[1\\(en15]"

msgid "/dev/sdb[1\\(en15]"
--
Man page: fstrim.8
Issue: Markup of fstrim

"Minimum contiguous free range to discard, in bytes. (This value is "
"internally rounded up to a multiple of the filesystem block size.)  Free "
"ranges smaller than this will be ignored and fstrim will adjust the minimu=
m "
"if it's smaller than the device's minimum, and report that (fstrim_range."
"minlen) back to userspace.  By increasing this value, the fstrim operation=
 "
"will complete more quickly for filesystems with badly fragmented freespace=
, "
"although not all blocks will be discarded.  The default value is zero, "
"discarding every free block."
--
Man page: getopt.1
Issue: Missing comma when enumarating Shells (after sh)

"Set quoting conventions to those of I<shell>.  If the B<-s> option is not "
"given, the E<.SM BASH> conventions are used.  Valid arguments are currentl=
y "
"'B<sh>' 'B<bash>', 'B<csh>', and 'B<tcsh>'."
--
Man page: hardlink.1
Issue: Markup up of command options missing

"Among equal files, keep the oldest file (least recent modification time). =
By "
"default, the newest file is kept. If --maximize or --minimize is specified=
, "
"the link count has a higher precedence than the time of modification."

"A regular expression to include files. If the option --exclude has been "
"given, this option re-includes files which would otherwise be excluded. If=
 "
"the option is used without --exclude, only files matched by the pattern ar=
e "
"included."

"B<hardlink> , as of version 0.3 RC1, improperly calculates the amount of "
"space saved if the option --respect-name is specified. In previous version=
s, "
"the amount was wrong in almost all other cases as well."
--
Man page: hardlink.1
Issue: Markup up of "hardlink" missing

"B<hardlink> assumes that the trees it operates on do not change during "
"operation. If a tree does change, the result is undefined and potentially "
"dangerous. For example, if a regular file is replaced by a device, hardlin=
k "
"may start reading from the device. If a component of a path is replaced by=
 a "
"symbolic link or file permissions change, security may be compromised. Do "
"not run hardlink on a changing tree or on a tree controlled by another use=
r."

"The program hardlink and this manpage have been written by Julian Andres "
"Klode, and are licensed under the MIT license. See the code of hardlink fo=
r "
"further information."
--
Man page: hexdump.1
Issue: When markup is used (B<>), no extra quoting is necessary

"I<Canonical hex+ASCII display>.  Display the input offset in hexadecimal, "
"followed by sixteen space-separated, two-column, hexadecimal bytes, follow=
ed "
"by the same sixteen bytes in B<%_p> format enclosed in 'B<|>' characters."

"Output characters in the default character set.  Non-printing characters a=
re "
"displayed as a single 'B<\\&.>'."
--
Man page: hexdump.1
Issue: Missing closing bracket (for fprintf)

"The format is required and must be surrounded by double quote (\" \") "
"marks.  It is interpreted as a fprintf-style format string (see "
"B<fprintf>(3), with the following exceptions:"
--
Man page: hexdump.1
Issue: identical =E2=86=92 almost identical

"Identical to the B<\\&_a> conversion string except that it is only perform=
ed "
"once, when all of the input data has been processed."
--
Man page: hexdump.1
Issue: Missing mark up for "hexdump"

"When put at the end of a format specifier, hexdump highlights the respecti=
ve "
"string with the color specified.  Conditions, if present, are evaluated "
"prior to highlighting."

"The hexdump command is part of the util-linux package and is available fro=
m "
"E<.UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> "
"Linux Kernel Archive E<.UE .>"
--
Man page: hexdump.1
Issue: Mixed markup (B<>) and quoting for conversion characters

"Further output by such format strings is replaced by an equivalent number =
of "
"spaces.  An equivalent number of spaces is defined as the number of spaces=
 "
"output by an B<s> conversion character with the same field width and "
"precision as the original conversion character or conversion string but wi=
th "
"any 'B<\\&+>', \\' \\', 'B<\\&#>' conversion flag characters removed, and "
"referencing a NULL string."
--
Man page: hexdump.1
Issue: ``|'' =E2=86=92 B<|>

"E<.Em Canonical hex+ASCII display>.  Display the input offset in "
"hexadecimal, followed by sixteen space-separated, two column, hexadecimal "
"bytes, followed by the same sixteen bytes in %_p format enclosed in ``|'' "
"characters."
--
Man page: hwclock.8
Issue: Markup up correct? (around option)

"Use\\ B<--verbose>.  The\\ B<\\%--debug\\ >option has been deprecated and "
"may be repurposed or removed in a future release."
--
Man page: hwclock.8
Issue: Replace comma by full stop

"Update the Hardware Clock's drift factor in I</etc/adjtime>.  It can only =
be "
"used with B<--set> or B<\\%--systohc>,"
--
Man page: hwclock.8
Issue: Paragraph hard to read

"Significantly increased system shutdown times (as of v2.31 when not using =
B<"
"\\%--update-drift> the RTC is not read)."
--
Man page: hwclock.8
Issue: date-time =E2=86=92 date time??

msgid "There are two types of date-time clocks:"
--
Man page: hwclock.8
Issue: Spaces in and around the final B<>

"Some Linux distributions attempt to automatically calculate the System Clo=
ck "
"drift with B<\\%adjtimex>'s compare operation.  Trying to correct one "
"drifting clock by using another drifting clock as a reference is akin to a=
 "
"dog trying to catch its own tail.  Success may happen eventually, but grea=
t "
"effort and frustration will likely precede it.  This automation may yield =
an "
"improvement over no configuration, but expecting optimum results would be =
in "
"error.  A better choice for manual configuration would be B<\\%adjtimex>'s=
B< "
"--log >options."
--
Man page: hwclock.8
Issue: Missing Space at beginning of line

msgid "TheI< System Clock >time must be correct at shutdown!"
--
Man page: libblkid.3
Issue: evaluate =E2=86=92 determine?

"The high-level part of the library supports two methods to evaluate LABEL/"
"UUID.  It reads information directly from a block device or read informati=
on "
"from /dev/disk/by-* udev symlinks.  The udev is preferred method by defaul=
t."
--
Man page: libblkid.3
Issue: Missing markup for command name

"libblkid is part of the util-linux package since version 2.15 and is "
"available from https://www.kernel.org/pub/linux/utils/util-linux/."
--
Man page: logger.1
Issue: Superfluous space before full stop

"Use datagrams (UDP) only.  By default the connection is tried to the syslo=
g "
"port defined in /etc/services, which is often 514 ."
--
Man page: logger.1
Issue: Missing markup of command name

"Log the PID of the logger process with each line.  When the optional "
"argument I<id> is specified, then it is used instead of the logger command=
's "
"PID.  The use of B<--id=3D$$> (PPID) is recommended in scripts that send "
"several messages."

"Write a systemd journal entry.  The entry is read from the given I<file>, "
"when specified, otherwise from standard input.  Each line must begin with =
a "
"field that is accepted by journald; see B<systemd.journal-fields>(7)  for "
"details.  The use of a MESSAGE_ID field is generally a good idea, as it "
"makes finding entries easy.  Examples:"

"Use the specified I<port>.  When this option is not specified, the port "
"defaults to syslog for udp and to syslog-conn for tcp connections."

"Most receivers accept messages larger than 1KiB over any type of syslog "
"protocol.  As such, the B<--size> option affects logger in all cases (not "
"only when B<--rfc5424> was used)."
--
Man page: logger.1
Issue: or the journal =E2=86=92 to the journal?

"Causes everything to be done except for writing the log message to the "
"system log, and removing the connection or the journal.  This option can b=
e "
"used together with B<--stderr> for testing purposes."
--
Man page: logger.1
Issue: Missing markup of parameters

"B<logger> currently generates the B<timeQuality> standardized element only=
=2E  "
"RFC 5424 also describes the elements B<origin> (with parameters ip, "
"enterpriseId, software and swVersion) and B<meta> (with parameters "
"sequenceId, sysUpTime and language).  These element IDs may be specified "
"without the B<@>I<digits> suffix."
--
Man page: logger.1
Issue: Missing markup file names, command names etc.

"Print errors about Unix socket connections.  The I<mode> can be a value of=
 "
"B<off>, B<on>, or B<auto>.  When the mode is auto logger will detect if th=
e "
"init process is systemd, and if so assumption is made /dev/log can be used=
 "
"early at boot.  Other init systems lack of /dev/log will not cause errors "
"that is identical with messaging using B<openlog>(3)  system call.  The "
"B<logger>(1)  before version 2.26 used openlog, and hence was unable to "
"detected loss of messages sent to Unix sockets."
--
Man page: logger.1
Issue: The =C2=BBto=C2=AB marks a range inside a list. Shouldn't be bold.

msgid "B<  to>"
--
Man page: logger.1
Issue: Missing markup for command name

"The logger command is part of the util-linux package and is available from=
 "
"E<.UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> "
"Linux Kernel Archive E<.UE .>"
--
Man page: login.1
Issue: Missing full stop

"The default is to check I</etc\\:/hushlogins> and if it does not exist the=
n "
"I<~/.hushlogin>"

"If set, it will be used to define the PATH environment variable when a "
"regular user logs in.  The default value is I</usr\\:/local\\:/bin:\\:/bin=
:"
"\\:/usr\\:/bin>"
--
Man page: login.1
Issue: Missing markup for lastlog

"Highest user ID number for which the lastlog entries should be updated.  A=
s "
"higher user IDs are usually tracked by remote user identity and "
"authentication services there is no need to create a huge sparse lastlog "
"file for them.  No LASTLOG_UID_MAX option present in the configuration mea=
ns "
"that there is no user ID limit for writing lastlog entries."
--
Man page: login.1
Issue: Missing markup for command name

"A recursive login, as used to be possible in the good old days, no longer "
"works; for most purposes B<su>(1)  is a satisfactory substitute.  Indeed, "
"for security reasons, login does a vhangup() system call to remove any "
"possible listening processes on the tty.  This is to avoid password "
"sniffing.  If one uses the command B<login>, then the surrounding shell ge=
ts "
"killed by vhangup() because it's no longer the true owner of the tty.  Thi=
s "
"can be avoided by using B<exec login> in a top-level shell or xterm."
--
Man page: login.1
Issue: Missing markup for command name

"The login command is part of the util-linux package and is available from =
E<."
"UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linu=
x "
"Kernel Archive E<.UE .>"
--
Man page: lscpu.1
Issue: superfluous quoting around B<>

"When specifying the I<list> argument, the string of option, equal sign (=
=3D), "
"and I<list> must not contain any blanks or other whitespace.  Examples: 'B=
<-"
"C=3DNAME,ONE-SIZE>' or 'B<--caches=3DNAME,ONE-SIZE>'."
--
Man page: lslogins.1
Issue: specify =E2=86=92 specified, than =E2=86=92 then

"Note that relation between user and group may be invisible for primary gro=
up "
"if the user is not explicitly specify as group member (e.g., in /etc/group=
). "
"If the command lslogins scans for groups than it uses groups database only=
, "
"and user database with primary GID is not used at all."
--
Man page: lslogins.1
Issue: IDS =E2=86=92 IDs

"Only show data of users with a login specified in I<logins> (user names or=
 "
"user IDS).  More than one login may be specified; the list has to be comma=
-"
"separated.  The unknown login names are ignored."
--
Man page: lslogins.1
Issue: Markup and closing bracket are wrongly interleaved

msgid "Display information related to login by password (see also B<-afL).>"
--
Man page: lsmem.1
Issue: output compatible =E2=86=92 output is compatible

"The default output compatible with original implementation from s390-tools=
, "
"but it's strongly recommended to avoid using default outputs in your "
"scripts.  Always explicitly define expected columns by using the B<--outpu=
t> "
"option together with a columns list in environments where a stable output =
is "
"required."
--
Man page: lsmem.1
Issue: First sentence: Broken?

"The B<lsmem> command lists a new memory range always when the current memo=
ry "
"block distinguish from the previous block by some output column.  This "
"default behavior is possible to override by the B<--split> option (e.g., "
"B<lsmem --split=3DZONES>).  The special word \"none\" may be used to ignor=
e "
"all differences between memory blocks and to create as large as possible "
"continuous ranges.  The opposite semantic is B<--all> to list individual "
"memory blocks."
--
Man page: lsns.8
Issue: 2nd sentence broken wording

"B<NSFS> column, printed when B<net> is specified for B<--type> option, is "
"special; it uses multi-line cells.  Use the option B<--nowrap> is for "
"switching to \",\" separated single-line representation."
--
Man page: mkswap.8
Issue: No such section in swapon.8

"Please read notes from B<swapon>(8)  about B<the swap file use restriction=
s> "
"(holes, preallocation and copy-on-write issues)."
--
Man page: mount.8
Issue: bythe =E2=86=92 by the

"The same filesystem may be mounted more than once, and in some cases (e.g.=
, "
"network filesystems) the same filesystem may be mounted on the same "
"mountpoint more times. The mount command does not implement any policy to "
"control this behavior. All behavior is controlled by the kernel and it is "
"usually specific to the filesystem driver. The exception is B<--all>, in "
"this case already mounted filesystems are ignored (see B<--all> below for "
"more details)."
--
Man page: mount.8
Issue: disables B<--options-source-force> =E2=86=92 enables!

"Source of default options.  I<source> is comma separated list of B<fstab>,=
 "
"B<mtab> and B<disable>.  B<disable> disables B<fstab> and B<mtab> and "
"disables B<--options-source-force>.  Default value is B<fstab,mtab>."
--
Man page: mount.8
Issue: The wording is rather unusual english, improve?

"Note that specify B<-w> on command line forces B<mount> command to never t=
ry "
"read-only mount on write-protected devices. The default is try read-only i=
f "
"the previous mount syscall with read-write flags failed."
--
Man page: mount.8
Issue: Does this include other executable like scripts?

msgid "Permit execution of binaries."
--
Man page: mount.8
Issue: maintain =E2=86=92 maintaining

"The same as B<X-*> options, but stored permanently in the user space. It "
"means the options are also available for umount or another operations.  No=
te "
"that maintain mount options in user space is tricky, because it's necessar=
y "
"use libmount based tools and there is no guarantee that the options will b=
e "
"always available (for example after a move mount operation or in unshared "
"namespace)."
--
Man page: mount.8
Issue: mount =E2=86=92 B<mount>

"Allow to make a target directory (mountpoint) if it does not exit yet.  Th=
e "
"optional argument I<mode> specifies the filesystem access mode used for "
"B<mkdir>(2)  in octal notation.  The default mode is 0755.  This "
"functionality is supported only for root users or when mount executed "
"without suid permissions.  The option is also supported as x-mount.mkdir, "
"this notation is deprecated since v2.30."
--
Man page: mount.8
Issue: URL does not allow login (2019-01-29)

"A remount option which permits online expansion of reiserfs partitions.  "
"Instructs reiserfs to assume that the device has I<number> blocks.  This "
"option is designed for use with devices which are under logical volume "
"management (LVM).  There is a special I<resizer> utility which can be "
"obtained from I<ftp://ftp.namesys.com/pub/reiserfsprogs>."
--
Man page: mount.8
Issue: man page is no longer available from the attr project: http://git.sa=
vannah.nongnu.org/cgit/attr.git/tree/man

msgid "Enable Extended User Attributes.  See the B<attr>(1)  manual page."
--
Man page: mount.8
Issue: Nowadays it is only called macOS

"For filesystems created by OpenStep (currently read only).  The same "
"filesystem type is also used by Mac OS X."
--
Man page: nologin.8
Issue: Missing markup for command name

"If the file /etc/nologin.txt exists, nologin displays its contents to the "
"user instead of the default message."

"The nologin command is part of the util-linux package and is available fro=
m "
"E<.UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> "
"Linux Kernel Archive E<.UE .>"
--
Man page: nsenter.1
Issue: The second sentence is missing a =C2=BBin B<clone>(2).=C2=AB?

"Children will have a set of PID to process mappings separate from the "
"B<nsenter> process For further details, see B<pid_namespaces>(7)  and the "
"discussion of the B<CLONE_NEWPID> flag in B<nsenter> will fork by default =
if "
"changing the PID namespace, so that the new program and its children share=
 "
"the same PID namespace and are visible to each other.  If B<--no-fork> is "
"used, the new program will be exec'ed without forking."
--
Man page: raw.8
Issue: Superfluous space after B<-q>

msgid "With B<-q> , specify that all bound raw devices should be queried."
--
Man page: rfkill.8
Issue: B<block id|type> =E2=86=92 B<block >I<id|type>

msgid "B<block id>|B<type> [...]"

msgid "B<unblock id>|B<type> [...]"
--
Man page: rtcwake.8
Issue: to terminal =E2=86=92 the terminal

"The suspend setup may be interrupted by active hardware; for example "
"wireless USB input devices that continue to send events for some fraction =
of "
"a second after the return key is pressed.  B<rtcwake> tries to avoid this "
"problem and it waits to terminal to settle down before entering a system "
"sleep."
--
Man page: runuser.1
Issue: Markup missing and copy =E2=86=92 sync?
=20
"Create pseudo-terminal for the session. The independent terminal provides "
"better security as user does not share terminal with the original session.=
  "
"This allow to avoid TIOCSTI ioctl terminal injection and another security "
"attacks against terminal file descriptors. The all session is also possibl=
e "
"to move to background (e.g., \"runuser --pty -u username -- command &\"). =
 "
"If the pseudo-terminal is enabled then runuser command works as a proxy "
"between the sessions (copy stdin and stdout)."
--
Man page: script.1
Issue: B<scriptreplay (1)> =E2=86=92 B<scriptreplay>(1)

"B<script> makes a typescript of everything on your terminal session.  The "
"terminal data are stored in raw form to the log file and information about=
 "
"timing to another (optional) structured log file.  The timing log file is "
"necessary to replay the session later by B<scriptreplay (1)> and to store "
"additional information about the session."
--
Man page: script.1
Issue 1: or all the on =E2=86=92 or all in the one
Issue 2: supports new timing =E2=86=92 supports a new timing

"Since version 2.35 B<script> supports multiple streams and allows to log "
"input and output to separate files or all the one file.  This version also=
 "
"supports new timing file which records additional information.  The comman=
d "
"B<scriptreplay --summary> then provides all the information."
--
Man page: script.1
Issue 1: itentifier =E2=86=92 identifier
Issue 2: socond =E2=86=92 second

"The first field is entry type itentifier ('I'nput, 'O'utput, 'H'eader, "
"'S'ignal).  The socond field is how much time elapsed since the previous "
"entry, and rest of the entry is type specific data."
--
Man page: script.1
Issue: Superfluous comma at the end

"B<csh>(1)  (for the I<history> mechanism), B<scriptreplay>(1), "
"B<scriptlive>(1),"
--
Man page: script.1
Issue: Missing markup for command name

"B<script> is primarily designed for interactive terminal sessions.  When "
"stdin is not a terminal (for example: B<echo foo | script>), then the "
"session can hang, because the interactive shell within the script session "
"misses EOF and B<script> has no clue when to close the session.  See the "
"B<NOTES> section for more information."

"The script command is part of the util-linux package and is available from=
 "
"E<.UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> "
"Linux Kernel Archive E<.UE .>"
msgstr ""
"Der Befehl B<script> ist Teil des Pakets util-linux, welches aus dem E<.UR=
 "
"https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linux "
"Kernel-Archiv E<.UE> heruntergeladen werden kann."
--
Man page: scriptlive.1
Issue 1: --log-io =E2=86=92 B<--log-io>
Issue 2: --log-in =E2=86=92 B<--log-in>

"B<Be careful!> Do not forget that the typescript may contains arbitrary "
"commands.  It is recommended to use B<\"scriptreplay --stream in --log-in "
"typescript\"> (or with --log-io instead of --log-in) to verify the "
"typescript before it is executed by B<scriptlive>(1)."
--
Man page: scriptlive.1
Issue 1: B<script (1)> =E2=86=92 B<script>(1)
Issue 2: split the groff code correctly

"aliast to B<-t>, maintained for compatibility with B<script (1)> command "
"line options.  B<-d>,B< --divisor >I<number> Speed up the replay displayin=
g "
"this I<number> of times.  The argument is a floating point number.  It's "
"called divisor because it divides the timings by this factor.  This option=
 "
"overrides old-style arguments."
--
Man page: scriptlive.1
Issue: scriptlive =E2=86=92 B<scriptlive>

"The scriptlive command is part of the util-linux package and is available "
"from E<.UR https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linu=
x/"
"> Linux Kernel Archive E<.UE .>"
--
Man page: scriptreplay.1
Issue: second =C2=BBspeed-up=C2=AB should be actually =C2=BBspeed-down=C2=AB

"If the third parameter or B<--divisor> is specified, it is used as a speed=
-"
"up multiplier.  For example, a speed-up of 2 makes B<scriptreplay> go twic=
e "
"as fast, and a speed-up of 0.1 makes it go ten times slower than the "
"original session."
--
Man page: scriptreplay.1
Issue 1: aliast =E2=86=92 alias
Issue 2: B<script (1)> =E2=86=92 B<script>(1)

"aliast to B<-t>, maintained for compatibility with B<script (1)> command "
"line options."
--
Man page: scriptreplay.1
Issue: scriptreplay =E2=86=92 B<scriptreplay>

"Specifies how to use CR (0x0D, carriage return) character from log files. =
 "
"The default mode is I<auto>, in this case CR is replaced with line break f=
or "
"stdin log, because otherwise scriptreplay will overwrite the same line.  T=
he "
"another modes are I<never> and I<always>."
--
Man page: scriptreplay.1
Issue: B<script>(1)) =E2=86=92 B<script>(1)

"Display details about session recorded in the specified timing file and "
"exit.  The session has to be recorded by I<advanced> format (see "
"B<script>(1))  option B<--logging-format> for more details)."
--
Man page: scriptreplay.1
Issue 1: scriptreplay =E2=86=92 B<scriptreplay>
Issue 2: --log-io =E2=86=92 B<--log-io>

"Forces scriptreplay to print only specified stream.  The supported stream "
"types are I<in>, I<out>, I<signal>, or I<info>.  This option is recommende=
d "
"for multi-stream logs (e.g., --log-io)  to print only specified data."
--
Man page: scriptreplay.1
Issue: output doesn't match the real output exactly

"% script --log-timing file.tm --log-out script.out\n"
"Script started, file is script.out\n"
"% ls\n"
"E<lt>etc, etcE<gt>\n"
"% exit\n"
"Script done, file is script.out\n"
--
Man page: setarch.8
Issue: arch =E2=86=92 setarch?

msgid "B<arch> [options] [I<program> [I<argument>...]]"
--
Man page: setpriv.1
Issue: regual =E2=86=92 regular

"Clears all the environment variables except TERM; initializes the "
"environment variables HOME, SHELL, USER, LOGNAME according to the user's "
"passwd entry; sets PATH to I</usr/local/bin:/bin:/usr/bin> for a regual us=
er "
"and to I</usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin> for=
 "
"root."
--
Man page: sfdisk.8
Issue: sfdisk =E2=86=92 B<sfdisk>

"The optional I<path> specifies log file name. The log file contains "
"information about all read/write operations on the partition data. The wor=
d "
"\"@default\" as a I<path> forces sfdisk to use ~/sfdisk-E<lt>devnameE<gt>."
"move for the log.  The log is optional since v2.35."

"Specify sector size. This header is informative only and it is not used wh=
en "
"sfdisk creates a new partition table, in this case the real device specifi=
c "
"value is always used and sector size from the dump is ignored."
--
Man page: sfdisk.8
Issue 1: fsync =E2=86=92 B<fsync>(2)
Issue 2: dara =E2=86=92 data

"Use fsync system call after each write when move dara to a new location by=
 "
"B<--move-data>."
--
Man page: sfdisk.8
Issue: partitions =E2=86=92 partition

"Wipe filesystem, RAID and partition-table signatures from a newly created "
"partitions, in order to avoid possible collisions.  The argument I<when> c=
an "
"be B<auto>, B<never> or B<always>.  When this option is not given, the "
"default is B<auto>, in which case signatures are wiped only when in "
"interactive mode and after confirmation by user.  In all cases detected "
"signatures are reported by warning messages after a new partition is "
"created.  See also B<wipefs>(8)  command."
--
Man page: sfdisk.8
Issue: Last sentence: If the ... then the

"The default value of I<start> is the first non-assigned sector aligned "
"according to device I/O limits.  The default start offset for the first "
"partition is 1 MiB.  The offset may be followed by the multiplicative "
"suffixes (KiB, MiB, GiB, TiB, PiB, EiB, ZiB and YiB) then the number is "
"interpreted as offset in bytes."
--
Man page: sfdisk.8
Issue: Last sentence: The offset =E2=80=A6 then =E2=86=92 If the offset =E2=
=80=A6 then

"The first non-assigned sector aligned according to device I/O limits.  The=
 "
"default start offset for the first partition is 1 MiB. The offset may be "
"followed by the multiplicative suffixes (KiB, MiB, GiB, TiB, PiB, EiB, ZiB=
 "
"and YiB) then the number is interpreted as offset in bytes."
--
Man page: sfdisk.8
Issue: s ir =E2=86=92 it

"I<bootable> is specified as [B<*>|B<->], with as default not-bootable.  Th=
e "
"value of this field is irrelevant for Linux - when Linux runs it has been "
"booted already - but ir might play a role for certain boot loaders and for=
 "
"other operating systems."
--
Man page: su.1
Issue: Missing markup for command name

"The su command is part of the util-linux package and is available from E<.=
UR "
"https://\\:www.kernel.org\\:/pub\\:/linux\\:/utils\\:/util-linux/> Linux "
"Kernel Archive E<.UE .>"
--
Man page: swapon.8
Issue: Missing markup for nocow

"Swap files on Btrfs are supported since Linux 5.0 on files with nocow "
"attribute.  See the B<btrfs>(5)  manual page for more details."
--
Man page: swapon.8
Issue: Missing markup for command name

"The swapon command is part of the util-linux package and is available from=
 "
"https://www.kernel.org/pub/linux/utils/util-linux/."
--
Man page: swapon.8
Issue: not be static =E2=86=92 be dynamic

"B<swapon> may not work correctly when using a swap file with some versions=
 "
"of B<btrfs>.  This is due to btrfs being a copy-on-write filesystem: the "
"file location may not be static and corruption can result.  Btrfs actively=
 "
"disallows the use of swap files on its filesystems by refusing to map the "
"file."
--
Man page: umount.8
Issue: libmount =E2=86=92 B<libmount>

"Since version 2.35 B<umount> command does not exit when user permissions a=
re "
"inadequate by internal libmount security rules.  It drops suid permissions=
 "
"and continue as regular non-root user. It allows to support use-cases wher=
e "
"root permissions are not necessary (e.g., fuse filesystems, user namespace=
s, "
"etc)."
--
Man page: unshare.1
Issue: =3D =E2=86=92 B<=3D>?

msgid "B<-C>,B< --cgroup>[=3DI<file>]"
--
Man page: unshare.1
Issue: can not =E2=86=92 cannot

"The proc and sysfs filesystems mounting as root in a user namespace have t=
o "
"be restricted so that a less privileged user can not get more access to "
"sensitive files that a more privileged user made unavailable. In short the=
 "
"rule for proc and sysfs is as close to a bind mount as possible."
--
Man page: wdctl.8
Issue: than =E2=86=92 then

"If the device is already used or user has no permissions to read from the "
"device than B<wdctl> reads data from sysfs.  In this case information abou=
t "
"supported features (flags) might be missing."
--
Man page: wdctl.8
Issue: Missing markup for command name

"The write command is part of the util-linux package and is available from "
"https://www.kernel.org/pub/linux/utils/util-linux/."

Greetings

           Helge

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-28279-1588533216-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAl6vF98ACgkQQbqlJmgq
5nAOrA/8D4lIkxt13ZDUEVGfwS7s47RDIoO986LyWLe6TSHZCIjxSiYIEhJwRrwH
b5YeIQoVFGAHMsoRbrY7NcsKk8SMQ05GnpY/x5vLpZKurSDCwjL7XN6JwH68eaQp
Zz7xHS66UgftgHtPKGeQDiMM52ev1Q/vxYUDuUTi+7gkvVu/95Hi+0bgDI6hCOJ7
OqqIEqEjFUOPhbhKZgYS0AWy9030KDOjBGZ2rTUkI6utO1iZlVIk3egdtv060wYE
ko+n0ae/GI2txS67ZC37O1Q6uOTxjl6Zta2CvgsZ9ZPM1Lbel+ZqxVYoXBaX/3pv
mkjXQAUVVLH69+Tr2J8m6AQu2bYYPQhAnND0lYqFsQmFaHCpsUgY+bJQaNEjrjpY
kcgdaOX0c6YdJZZt9wnx8mHaMpqOXQ1ghCFRW377eBUWI7mE4v97qrmDtDAimEIn
pdYNC0W2WkG8GXDfxlidScuHsMYICDhxR7j3p2ECMRJ2zcpDD64aNr32HzJEUhJV
cJCyLeCzk/HUBynJSRLeFKUo5w9myeL8wuKg5P9arIx7vZgJlMfrvi4PfO6DZXKr
tShRIWxCHOgaF9VCjO864C+ROE5LIje7WefNliYrphb9bucMD4HtBiv1D3P1ejH8
Hs62spetyAWlRm3/SD7vkbni9iEXrW0Byd6Ncl6szUJBvmSqnJI=
=0rwy
-----END PGP SIGNATURE-----

--=_luckmann.name-28279-1588533216-0001-2--
