Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: hwclock questions
Date: Fri, 6 Jun 2014 15:06:31 +0200
Cc: util-linux@vger.kernel.org
References: <201406050032.24233.sweet_f_a@gmx.de> <20140605074805.GV9000@x2.net.home> <201406051445.31366.sweet_f_a@gmx.de>
In-Reply-To: <201406051445.31366.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406061506.31999.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 05 June 2014, Ruediger Meier wrote:
> On Thursday 05 June 2014, Karel Zak wrote:
> > On Thu, Jun 05, 2014 at 12:32:24AM +0200, Ruediger Meier wrote:
> > > But before doing this I have two questions.
> >
> >  Maybe we can remove the test at all (or use --force to enable the
> > test). It was always very problematic test
>
> I will try to make it a bit more robust and then see if we still
> should make it optional.

I've rewrote it and sent patch to github
https://github.com/karelzak/util-linux/pull/94

Below the full script (better to read than the patch in this case).
Please comment.

# tests/ts/hwclock/systohc:

TS_TOPDIR="${0%/*}/../.."
TS_DESC="system to hw"
NTP_SERVER="0.fedora.pool.ntp.org"

. $TS_TOPDIR/functions.sh
ts_init "$*"

ts_check_test_command "$TS_CMD_HWCLOCK"

ts_skip_nonroot
ts_check_prog "bc"
ts_check_prog "sntp"

function resolve_host
{
	local host="$1"
	local tmp

	# currently we just resolve default records (might be "A", ipv4 only)
	if type "dig" >/dev/null 2>&1; then
		tmp=$(dig "$host" +short 2>/dev/null) || return 1
	elif type "nslookup" >/dev/null 2>&1; then
		tmp=$(nslookup "$host" 2>/dev/null) || return 1
		tmp=$(echo "$tmp"| grep -A1 "^Name:"| grep "^Address:"| cut -d" " -f2)
	fi

	# we return 1 if tmp is empty
	test -n "$tmp" || return 1
	echo "$tmp" | sort -R | head -n 1
}

function get_offset_sys_ntp
{
	local ips="$@"
	local out

	out=$(sntp -K "$SNTP_KOD" --timeout 1 "$ips") || return 1

	# sed must deliver a signed float or empty string for sure
	out=$(echo "$out" | \
		sed -n 's/.* \(\(+\|-\)[0-9]\{1,\}\.*[0-9]*\) +\/-.*secs$/\1/p')

	[ -n "$out" ] || return 1
	echo "$out"
}

function check_diff_offset
{
	local a=${1#+}
	local b=${2#+}
	local max="$3"
	local tmp

	tmp=$(echo "$a - $b" | bc | tr -d '-')
	echo "$tmp"

	tmp=$(echo "$tmp < $max" | bc)
	[ $tmp -eq 1 ]
}


# we need fixed ntp IP to get comparable offsets
NTP_IP=$(resolve_host "$NTP_SERVER") \
	|| ts_skip "can't resolve hostname $NTP_SERVER"

# needed in get_offset_sys_ntp
SNTP_KOD="$(mktemp "${TS_OUTDIR}/kod-XXXX")"

OFFSET_A=$(get_offset_sys_ntp "$NTP_IP") \
	|| ts_skip "can't get ntp offset 1st, $NTP_IP"
OFFSET_B=$(get_offset_sys_ntp "$NTP_IP") \
	|| ts_skip "can't get ntp offset 2nd, $NTP_IP"

diff=$(check_diff_offset $OFFSET_A $OFFSET_B 0.02) \
	|| ts_skip "unreliable ntp or sys clock offsets: $NTP_IP $OFFSET_A $OFFSET_B +/-$diff"

# hwclock --show should work if we have a hw clock
tmp=$($TS_CMD_HWCLOCK --show 2>&1)
if [ $? != "0" ]; then
	echo "$tmp" | grep -q "Cannot access the Hardware Clock via" \
		&& ts_skip "no hardware clock found"
	ts_failed "hwclock --show"
fi

# call hwclock
# TODO - try to be nice, use --localtime if wanted
for i in `seq 1 10`; do
	# only skip on failure for now
	$TS_CMD_HWCLOCK --systohc || ts_skip "--systohc, $i"
	$TS_CMD_HWCLOCK --hctosys || ts_skip "--hctosys, $i"
done

OFFSET_C=$(get_offset_sys_ntp "$NTP_IP") \
	|| ts_skip "can't get ntp offset 3rd, $NTP_IP"

diff=$(check_diff_offset "$OFFSET_B" "$OFFSET_C" 1.0) \
	|| ts_failed "offsets $NTP_IP: $OFFSET_B $OFFSET_C +/-$diff"

ts_ok "offsets $NTP_IP: $OFFSET_B $OFFSET_C +/-$diff"
