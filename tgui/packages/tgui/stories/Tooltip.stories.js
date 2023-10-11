/**
 * @file
 * @copyright 2021 Aleksej Komarov
 * @license MIT
 */

import { Box } from "../components/Box";
import { Button } from "../components/Button";
import { Section } from "../components/Section";
import { Tooltip } from "../components/Tooltip";

export const meta = {
  title: 'Tooltip',
  render: () => <Story />,
};

const Story = () => {
  const positions = [
    'top',
    'left',
    'right',
    'bottom',
    'bottom-start',
    'bottom-end',
  ];

  return (
    <Section>
      <Box>
        <Tooltip content="Tooltip text.">
          <Box inline position="relative" mr={1}>
            Box (hover me).
          </Box>
        </Tooltip>
        <Button
          tooltip="Tooltip text."
          content="Button" />
      </Box>
      <Box mt={1}>
        {positions.map(position => (
          <Button
            key={position}
            color="transparent"
            tooltip="Tooltip text."
            tooltipPosition={position}
            content={position} />
        ))}
      </Box>
    </Section>
  );
};
